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
      # Pace = actual visits at point in time - expected visits to meet frequency at that point in time
      service = @school_plan[:school_plan_services][0]
      expected = expected_visits(start_date: parse_date(service[:start_date]), end_date: parse_date(service[:end_date]), frequency: service[:frequency], interval: service[:interval])

      puts "pace #{service[:completed_visits_for_current_interval] - expected}"

      return {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1 , interval_for_extra_sessions_allowable: 'monthly', remaining_visits: 0, reset_date: '01-31-2022', pace: 4, pace_indicator: "🐇" }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1 , interval_for_extra_sessions_allowable: 'monthly', remaining_visits: 0, reset_date: '01-31-2022', pace: 4, pace_indicator: "🐇" }]}
    end

    def expected_visits(start_date:, end_date:, frequency:, interval:)
      start_of_treatment_date = parse_date("#{parse_date(@date).month}-#{start_date.day}-#{parse_date(@date).year}")

      end_of_treatment_date = start_of_treatment_date + COMMON_YEAR_DAYS_IN_MONTH[(parse_date(@date)).month]

      days_between = business_days(start_of_treatment_date, end_of_treatment_date).count

      days_passed = business_days(start_of_treatment_date, parse_date(@date)).count


      ((frequency/days_between.to_f) * days_passed).floor
      #, days_between, days_passed, "how are you doing bro"


      # visitable_days = business_days(start_date, start_date + COMMON_YEAR_DAYS_IN_MONTH[(parse_date(@date)).month]).count

      # visitable_days_left = business_days(parse_date(@date), start_date + COMMON_YEAR_DAYS_IN_MONTH[(parse_date(@date)).month]).count


      # puts parse_date(@date), "wellness", ((frequency.to_f / visitable_days) * (visitable_days - visitable_days_left)), "our expectation", frequency, "days left", visitable_days_left, visitable_days
    end

    def yearly_pacer
      # when interval is yearly
    end

    def monthly_pacer
      # when interval is monthly
    end

    def weekly_pacer
      # when interval is weekly
    end

    def parse_date(date)
      Date.strptime(date, '%m-%d-%Y')
    end

    def reset_date
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
  end
end