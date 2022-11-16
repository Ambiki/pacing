require 'date'
require 'holidays'

# visits are for all(summation)
# frequencies should be normalized(should be summed for one)(normalize towards month)
# pacing should be calculated on the discipline
# if start date is in holidays, move it to the end of the holidays


module Pacing
  # two modes(strict: use start dates strictly in calculating pacing)
  class Calculator
    COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    attr_reader :school_plan, :date, :non_business_days, :state, :mode, :interval, :summer_holidays

    def initialize(school_plan:, date:, non_business_days:, state: :us_tn, mode: :liberal, summer_holidays: [])
      @school_plan = school_plan
      @non_business_days = non_business_days
      @date = date
      @state = state
      @mode = [:strict, :liberal].include?(mode) ? mode : :liberal

      raise ArgumentError.new("You must pass in at least one school plan") if @school_plan.nil?
      raise TypeError.new("School plan must be a hash") if @school_plan.class != Hash

      raise ArgumentError.new('You must pass in a date') if @date.nil?
      raise TypeError.new("The date should be formatted as a string in the format mm-dd-yyyy") if @date.class != String || !/(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])-(19|20)\d\d/.match?(@date)
      raise ArgumentError.new('Date must be within the interval range of the school plan') if !date_within_range

      @non_business_days.each do |non_business_day|
        raise TypeError.new('"Non business days" dates should be formatted as a string in the format mm-dd-yyyy') if non_business_day.class != String || !/(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])-(19|20)\d\d/.match?(non_business_day)
      end

      @school_plan[:school_plan_services].each do |school_plan_service|
        raise TypeError.new("School plan type must be a string and cannot be nil") if school_plan_service[:school_plan_type].class != String || school_plan_service[:school_plan_type].nil?

        raise ArgumentError.new("School plan services start and end dates can not be nil") if school_plan_service[:start_date].nil? || school_plan_service[:end_date].nil?

        raise TypeError.new("School plan services start and end dates should be formatted as a string in the format mm-dd-yyyy") if school_plan_service[:start_date].class != String || !/(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])-(19|20)\d\d/.match?(school_plan_service[:start_date])

        raise TypeError.new("School plan services start and end dates should be formatted as a string in the format mm-dd-yyyy") if school_plan_service[:end_date].class != String || !/(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])-(19|20)\d\d/.match?(school_plan_service[:end_date])

        raise TypeError.new("Type of service must be a string and cannot be nil") if school_plan_service[:type_of_service].class != String || school_plan_service[:type_of_service].nil?

        raise TypeError.new("Frequency must be an integer and cannot be nil") if school_plan_service[:frequency].class != Integer || school_plan_service[:frequency].nil?

        raise TypeError.new("Interval must be a string and cannot be nil") if school_plan_service[:interval].class != String || school_plan_service[:interval].nil?

        raise TypeError.new("Time per session in minutes must be an integer and cannot be nil") if school_plan_service[:time_per_session_in_minutes].class != Integer || school_plan_service[:time_per_session_in_minutes].nil?

        raise TypeError.new("Completed visits for current interval must be an integer and cannot be nil") if school_plan_service[:completed_visits_for_current_interval].class != Integer || school_plan_service[:completed_visits_for_current_interval].nil?

        raise TypeError.new("Extra sessions allowable must be an integer and cannot be nil") if school_plan_service[:extra_sessions_allowable].class != Integer || school_plan_service[:extra_sessions_allowable].nil?

        raise TypeError.new("Interval for extra sessions allowable must be a string and cannot be nil") if school_plan_service[:interval_for_extra_sessions_allowable].class != String || school_plan_service[:interval_for_extra_sessions_allowable].nil?
      end

      @summer_holidays = summer_holidays.empty? ? parse_summer_holiday_dates : [parse_date(summer_holidays[0]), parse_date(summer_holidays[1])]
    end


    def interval
      # filter out services that haven't started or whose time is passed
      services = Pacing::Normalizer.new(@school_plan[:school_plan_services], date).services

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

    def parse_date(date)
      begin
        Date.strptime(date, '%m-%d-%Y')
      rescue => exception
      end
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
      (start_of_treatment_date(parse_date(start_date), interval) + COMMON_YEAR_DAYS_IN_MONTH[(parse_date(@date)).month]).strftime("%m-%d-%Y")
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

    def parse_summer_holiday_dates
      holidays_start = parse_date("05-13-#{parse_date(@date).year}")
      holidays_start += 1 until holidays_start.wday == 5

      holidays_end = parse_date("08-01-#{parse_date(@date).year}")
      holidays_start += 1 until holidays_start.wday == 1

      [holidays_start, holidays_end]
    end
  end
end

