require 'date'
require 'holidays'

module Pacing
  class Pacer
    COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    attr_reader :school_plan, :date, :non_business_days, :state

    def initialize(school_plan:, date:, non_business_days:, state: :us_tn)
      @school_plan = school_plan
      @non_business_days = non_business_days
      @date = date
      @state = state

      raise ArgumentError.new("You must pass in at least one school plan") if @school_plan.nil?
      raise TypeError.new("School plan must be a hash") if @school_plan.class != Hash
      
      raise ArgumentError.new('You must pass in a date') if @date.nil?
      raise TypeError.new("The date should be formatted as a string in the format mm-dd-yyyy") if @date.class != String || !/(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])-(19|20)\d\d/.match?(@date)
      
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
        service[:pace_indicator] = "🐇"

        service
      end

      { school_plan_services: services }
    end

    # get a spreadout of visit dates over an interval by using simple proportion.
    def expected_visits(start_date:, end_date:, frequency:, interval:)
      reset_start = start_of_treatment_date(start_date, interval)

      reset_end =  reset_start + interval_days(interval)

      days_between = business_days(reset_start, reset_end).count

      days_passed = business_days(reset_start, parse_date(@date)).count

      ((frequency/days_between.to_f) * days_passed).round
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

    def parse_date(date)
      Date.strptime(date, '%m-%d-%Y')
    end

    # days on which a session can hold
    def business_days(start_date, end_date)
      # remove saturdays and sundays
      # remove holidays(array from Ambiki)
      # remove school holidays/non business days
      working_days = (start_date..end_date).filter do |day|
        !(day.saturday? || day.sunday?)
      end

      holidays = Holidays.between(start_date, end_date, @state).map { |holiday| holiday[:date] }

      working_days - [@date] - @non_business_days - holidays
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
        return (start_of_treatment_date(parse_date(start_date), interval) + COMMON_YEAR_DAYS_IN_MONTH[(parse_date(@date)).month]-1).strftime("%m-%d-%Y")
      when "weekly"
        return (start_of_treatment_date(parse_date(start_date), interval) + 7).strftime("%m-%d-%Y")
      when "yearly"
        return (parse_date(@date).leap? ? parse_date(start_date) + 366 : parse_date(start_date) + 365).strftime("%m-%d-%Y")
      end
    end

    # scoped to the interval
    def start_of_treatment_date(start_date, interval="monthly")
      case interval
      when "monthly"
        return parse_date("#{parse_date(@date).month}-#{start_date.day}-#{parse_date(@date).year}")
      when "weekly"
        date = parse_date(@date)
        week_start_date = week_start(date)
        weekly_date = week_start_date + start_date.wday
        weekly_date = date < weekly_date ? weekly_date - 7 : weekly_date
        return weekly_date
      when "yearly"
        return parse_date("#{start_date.month}-#{start_date.day}-#{parse_date(@date).year}")
      end
    end

    def week_start(date, offset_from_sunday=0)
      date - ((date.wday - offset_from_sunday)%7)
    end    
  end
end