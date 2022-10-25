require 'date'
require 'holidays'

module Pacing
  # two modes(strict: use start dates strictly in calculating pacing)
  class Pacer
    COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    attr_reader :school_plan, :date, :non_business_days, :state, :mode, :interval

    def initialize(school_plan:, date:, non_business_days:, state: :us_tn, mode: :liberal)
      @school_plan = school_plan
      @non_business_days = non_business_days
      @date = date
      @state = state
      @mode = mode

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
    end

    def calculate
      services = @school_plan[:school_plan_services]

      services = services.map do |service|
        expected = expected_visits(start_date: parse_date(service[:start_date]), end_date: parse_date(service[:end_date]), frequency: service[:frequency], interval: service[:interval])

        service[:pace] = pace(service[:completed_visits_for_current_interval], expected)
        service[:reset_date] = reset_date(start_date: service[:start_date], interval: service[:interval_for_extra_sessions_allowable])
        service[:remaining_visits] = remaining_visits(completed_visits: service[:completed_visits_for_current_interval], required_visits: service[:frequency])
        service[:pace_indicator] = pace_indicator(service[:pace])

        service
      end

      { school_plan_services: services }
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

      # puts "the weekly #{days_between} end date: #{reset_end} start date: #{reset_start} and days_passed #{days_passed}, expected: #{visits}" if interval == "weekly"

      return visits
    end

    def interval_days(interval)
      case interval
      when "monthly"
        return COMMON_YEAR_DAYS_IN_MONTH[(parse_date(@date)).month]
      when "weekly"
        return 6
      when "yearly"
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
      working_days = get_working_days(start_date, end_date)

      holidays = get_holidays(start_date, end_date)
      
      working_days.sort - parsed_non_business_days.sort - holidays.sort
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
      when "monthly"
        return reset_date_monthly(start_date, interval)
      when "weekly"
        return reset_date_weekly(start_date, interval)
      when "yearly"
        return reset_date_yearly(start_date)
      end
    end

    # scoped to the interval
    def start_of_treatment_date(start_date, interval="monthly")
      case interval
      when "monthly"
        return start_of_treatment_date_monthly(start_date)
      when "weekly"
        return start_of_treatment_date_weekly(start_date)
      when "yearly"
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
      date - ((date.wday - offset_from_sunday)%7)
    end
    
    # reset date for the yearly interval
    def reset_date_yearly(start_date)
      (parse_date(@date).leap? ? parse_date(start_date) + 366 : parse_date(start_date) + 365).strftime("%m-%d-%Y")
    end

    # reset date for the monthly interval
    def reset_date_monthly(start_date, interval)
      (start_of_treatment_date(parse_date(start_date), interval) + COMMON_YEAR_DAYS_IN_MONTH[(parse_date(@date)).month]-1).strftime("%m-%d-%Y")
    end

    # reset date for the weekly interval
    def reset_date_weekly(start_date, interval)
      (start_of_treatment_date(parse_date(start_date), interval) + 7).strftime("%m-%d-%Y")
    end

    # start of treatment for the yearly interval
    def start_of_treatment_date_yearly(start_date)
      parse_date("#{start_date.month}-#{start_date.day}-#{parse_date(@date).year}")
    end

    # start of treatment for the montly interval
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
      date = parse_date(@date)

      week_start_date = week_start(date)
      weekly_date = week_start_date

      if week_start_date != parse_date(@date) && @mode == :strict
        weekly_date = week_start_date + start_date.wday #unless start_date.wday == 1
        weekly_date = date < weekly_date ? weekly_date - 7 : weekly_date
      end

      weekly_date
    end

    def date_within_range
      within_range = true

      begin
        @school_plan[:school_plan_services].each do |school_plan_service|
          if !(parse_date(school_plan_service[:start_date]) <= parse_date(@date) && parse_date(@date) <= parse_date(school_plan_service[:end_date]))
            within_range = false
          end
        end
      rescue => exception
        # within_range = false
      end
      
      within_range
    end
  end
end