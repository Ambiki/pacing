require 'date'
require 'holidays'

module Pacing
  class Pacer
    COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    attr_reader :school_plan, :date, :non_business_days, :state, :mode, :interval, :summer_holidays

    def initialize(school_plan:, date:, non_business_days:, state: :us_tn, mode: :liberal, summer_holidays: [])
      @school_plan = school_plan
      @non_business_days = non_business_days
      @date = date
      @state = state
      @mode = [:strict, :liberal].include?(mode) ? mode : :liberal

      Pacing::Error.new(school_plan: school_plan, date: date, non_business_days: non_business_days, state: state, mode: mode, summer_holidays: summer_holidays)

      @summer_holidays = summer_holidays.empty? ? parse_summer_holiday_dates : [parse_date(summer_holidays[0]), parse_date(summer_holidays[1])]
    end

    def interval
      # filter out services that haven't started or whose time is passed
      services = @school_plan[:school_plan_services].filter do |school_plan_service|
        within = true
        if !(parse_date(school_plan_service[:start_date]) <= parse_date(@date) && parse_date(@date) <= parse_date(school_plan_service[:end_date]))
          within = false
        end

        within
      end

      services = services.map do |service|
        if ["pragmatic language", "speech and language", "language", "speech", "language therapy", "speech therapy", "speech and language therapy", "speech language therapy"].include?(service[:type_of_service].downcase)
          discipline_name = "Speech Therapy"
        elsif ["occupation therapy", "occupational therapy"].include?(service[:type_of_service].downcase)
          discipline_name = "Occupational Therapy"
        elsif ["physical therapy"].include?(service[:type_of_service].downcase)
          discipline_name = "Physical Therapy"
        elsif ["feeding therapy"].include?(service[:type_of_service].downcase)
          discipline_name = "Feeding Therapy"
        end

        discipline = {}
        discipline[:discipline] = discipline_name
        discipline[:reset_date] = reset_date(start_date: service[:start_date], interval: service[:interval])
        discipline[:start_date] = start_of_treatment_date(parse_date(service[:start_date]), service[:interval]).strftime("%m-%d-%Y")
        discipline
      end
    end

    def calculate
      # filter out services that haven't started or whose time is passed
      school_plan_services = Pacing::Normalizer.new(@school_plan[:school_plan_services], @date).normalize
      services = school_plan_services[:school_plan_services].filter do |school_plan_service|
        within = true
        if !(parse_date(school_plan_service[:start_date]) <= parse_date(@date) && parse_date(@date) <= parse_date(school_plan_service[:end_date]))
          within = false
        end

        within
      end

      services = services.map do |service|
        discipline = {}

        expected = expected_visits(start_date: parse_date(service[:start_date]), end_date: parse_date(service[:end_date]), frequency: service[:frequency], interval: service[:interval])

        discipline[:pace] = pace(service[:completed_visits_for_current_interval], expected)

        discipline[:reset_date] = reset_date(start_date: service[:start_date], interval: service[:interval])

        discipline[:reset_date] = parse_date(discipline[:reset_date]) > parse_date(service[:end_date]) && service[:interval] == "yearly" ? service[:end_date] : discipline[:reset_date]

        discipline[:remaining_visits] = remaining_visits(completed_visits: service[:completed_visits_for_current_interval], required_visits: service[:frequency] + service[:extra_sessions_allowable])

        discipline[:pace_indicator] = pace_indicator(discipline[:pace])

        discipline[:used_visits] =  service[:completed_visits_for_current_interval]

        discipline[:suggested_rate] = suggested_rate(remaining_visits: discipline[:remaining_visits], start_date: parse_date(service[:start_date]), interval: service[:interval])

        discipline[:expected_visits_at_date] = expected

        discipline[:discipline] = service[:type_of_service]

        discipline[:pace_indicator] = pace_indicator(discipline[:pace])
        discipline[:pace_suggestion] = readable_suggestion(rate: discipline[:suggested_rate])

        discipline.delete(:suggested_rate)

        discipline
      end

      services
    end

    # get a spreadout of visit dates over an interval by using simple proportion.
    def expected_visits(start_date:, end_date:, frequency:, interval:)
      reset_start = start_of_treatment_date(start_date, interval)

      reset_end = end_of_treatment_date(reset_start, interval)

      days_between = business_days(reset_start, reset_end).count

      days_passed = 0

      visits = 0

      if parse_date(@date) > reset_start
        days_passed = business_days(reset_start, parse_date(@date)).count
      end

      if days_between != 0
        visits = ((frequency/days_between.to_f) * days_passed).round
      end

      return visits
    end

    def interval_days(interval)
      case interval
      when "monthly", "per month"
        return COMMON_YEAR_DAYS_IN_MONTH[(parse_date(@date)).month]
      when "weekly", "per week"
        return 6
      when "yearly", "per year"
        return parse_date(@date).leap? ? 366 : 365
      end
    end

    def pace(actual_visits, expected_visits)
      # Pace = actual visits at point in time - expected visits to meet frequency at that point in time
      actual_visits - expected_visits
    end

    def pace_indicator(pace)
      if pace == 0
        return "😁"
      elsif pace > 0
        return "🐇"
      elsif pace < 0
        return "🐢"
      end
    end

    def parse_date(date)
      begin
        Date.strptime(date, '%m-%d-%Y')
      rescue => exception
      end
    end

    def parsed_non_business_days
      @non_business_days.map do |day|
        parse_date(day)
      end
    end

    # days on which a session can hold
    def business_days(start_date, end_date)
      # remove saturdays and sundays
      # remove holidays(array from Ambiki)
      # remove school holidays/non business days
      # should we remove today?(datetime call?)
      summer = get_working_days(summer_holidays[0], summer_holidays[1])

      working_days = get_working_days(start_date, end_date)

      holidays = get_holidays(start_date, end_date)

      working_days.sort - parsed_non_business_days.sort - holidays.sort - summer.sort
    end

    # scoped to the interval
    def remaining_visits(completed_visits:, required_visits:)
      visits = required_visits.to_i - completed_visits.to_i
      visits = 0 if visits < 0
      visits
    end

    # scoped to the interval
    def reset_date(start_date:, interval:)
      case interval
      when "monthly", "per month"
        return reset_date_monthly(start_date, interval)
      when "weekly", "per week"
        return reset_date_weekly(start_date, interval)
      when "yearly", "per year"
        return reset_date_yearly(start_date)
      end
    end

    # scoped to the interval
    def start_of_treatment_date(start_date, interval="monthly")
      case interval
      when "monthly", "per month"
        return start_of_treatment_date_monthly(start_date)
      when "weekly", "per week"
        return start_of_treatment_date_weekly(start_date)
      when "yearly", "per year"
        return start_of_treatment_date_yearly(start_date)
      end
    end

    def get_working_days(start_date, end_date)
      (start_date..end_date).filter do |day|
        !(day.saturday? || day.sunday?)
      end
    end

    def get_holidays(start_date, end_date)
      begin
        Holidays.between(start_date, end_date, @state).map { |holiday| holiday[:date] }
      rescue => exception
      end
    end

    # get actual date of the first day of the week where date falls
    def week_start(date, offset_from_sunday=0)
      offset_from_sunday = @mode == :liberal ? 1 : 0
      return date if date.monday?
      date - ((date.wday - offset_from_sunday) % 7)
    end

    # reset date for the yearly interval
    def reset_date_yearly(start_date)
      (parse_date(@date).leap? ? parse_date(start_date) + 366 : parse_date(start_date) + 365).strftime("%m-%d-%Y")
    end

    # reset date for the monthly interval
    def reset_date_monthly(start_date, interval)
      month = (parse_date(@date)).month

      (start_of_treatment_date(parse_date(start_date), interval) + COMMON_YEAR_DAYS_IN_MONTH[month]).strftime("%m-%d-%Y")
    end

    # reset date for the weekly interval
    def reset_date_weekly(start_date, interval)
      (start_of_treatment_date(parse_date(start_date), interval) + 7).strftime("%m-%d-%Y")
    end

    # start of treatment for the yearly interval
    def start_of_treatment_date_yearly(start_date)
      start = parse_date("#{start_date.month}-#{start_date.day}-#{parse_date(@date).year}")
      if start > parse_date(date)
        start = start_date
      end

      start
      # start_date
    end

    # start of treatment for the monthly interval
    def start_of_treatment_date_monthly(start_date)
      if @mode == :strict
        return parse_date("#{parse_date(@date).month}-#{start_date.day}-#{parse_date(@date).year}")
      else
        return parse_date("#{parse_date(@date).month}-01-#{parse_date(@date).year}")
      end
    end

    def end_of_treatment_date(reset_start, interval)
      reset_start + interval_days(interval)
    end

    # start of treatment for the weekly interval
    def start_of_treatment_date_weekly(start_date)
      # TODO: Update with assumption that Monday is start of week
      # Future TODO: allow user to pass in configuration for start of week
      parsed_date = parse_date(@date)
      week_start_date = week_start(parsed_date)
      weekly_date = week_start_date

      if week_start_date != parsed_date && @mode == :strict
        weekly_date = week_start_date + start_date.wday # unless start_date.wday == 1
        weekly_date = parsed_date < weekly_date ? weekly_date - 7 : weekly_date
      end

      weekly_date
    end

    def date_within_range
      valid_range_or_exceptions = false

      begin
        @school_plan[:school_plan_services].each do |school_plan_service|
          if (parse_date(school_plan_service[:start_date]) <= parse_date(@date) && parse_date(@date) <= parse_date(school_plan_service[:end_date]))
            valid_range_or_exceptions = true
          end
        end
      rescue => exception
        valid_range_or_exceptions = true
      end

      valid_range_or_exceptions
    end

    def readable_suggestion(rate:)
      # rate = suggested_rate(remaining_visits: remaining_visits, start_date: start_date, interval: interval)

      if rate < 0.2
        'less than once per week'
      elsif rate >= 0.2 && rate < 0.25
        'once a week'
      elsif rate >= 0.25 && rate < 0.33
        'once every 4 days'
      elsif rate >= 0.33 && rate < 0.5
        'once every 3 days'
      elsif rate == 0.5
        'once every other day'
      elsif rate > 0.5 && rate < 1
        'about once every other day'
      elsif rate >= 1.00
        'once a day'
      end
    end

    def suggested_rate(remaining_visits:, start_date:, interval:)
      days_left = remaining_days(start_date: start_date, interval: interval).to_f
      days_left = 1 if days_left == 0
      (remaining_visits / days_left.to_f).round(2)
    end

    def remaining_days(start_date:, interval:)
      reset_start = start_of_treatment_date(start_date, interval)
      reset_end = end_of_treatment_date(reset_start, interval)

      days_left = business_days(parse_date(@date), reset_end).count

      days_left
    end

    def parse_summer_holiday_dates
      holidays_start = parse_date("05-13-#{parse_date(@date).year}")
      holidays_start += 1 until holidays_start.wday == 5

      holidays_end = parse_date("08-01-#{parse_date(@date).year}")
      holidays_start += 1 until holidays_start.wday == 1

      [holidays_start, holidays_end]
    end 
  end
end
