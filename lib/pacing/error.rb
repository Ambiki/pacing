require 'date'
require 'holidays'

module Pacing
  class Error
    attr_reader :school_plan, :date, :non_business_days, :state, :mode, :interval, :summer_holidays

    def initialize(school_plan:, date:, non_business_days:, state: :us_tn, mode: :liberal, summer_holidays: [])
      @school_plan = school_plan
      @non_business_days = non_business_days
      @date = date
      @state = state
      @mode = [:strict, :liberal].include?(mode) ? mode : :liberal

      raise ArgumentError.new("You must pass in at least one school plan") if school_plan.nil?
      raise TypeError.new("School plan must be a hash") if school_plan.class != Hash

      raise ArgumentError.new('You must pass in a date') if date.nil?
      raise TypeError.new("The date should be formatted as a string in the format mm-dd-yyyy") if date.class != String || !/(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])-(19|20)\d\d/.match?(date)
      raise ArgumentError.new('Date must be within the interval range of the school plan') if !date_within_range

      non_business_days.each do |non_business_day|
        raise TypeError.new('"Non business days" dates should be formatted as a string in the format mm-dd-yyyy') if non_business_day.class != String || !/(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])-(19|20)\d\d/.match?(non_business_day)
      end

      school_plan[:school_plan_services].each do |school_plan_service|
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

    def date_within_range
      valid_range_or_exceptions = false

      begin
        @school_plan[:school_plan_services].each do |school_plan_service|
          if (parse_date(school_plan_service[:start_date]) < parse_date(@date) && parse_date(@date) < parse_date(school_plan_service[:end_date]))
            valid_range_or_exceptions = true
          end
        end
      rescue => exception
        valid_range_or_exceptions = true
      end

      valid_range_or_exceptions
    end

    def parse_date(date)
      begin
        Date.strptime(date, '%m-%d-%Y')
      rescue => exception
      end
    end
  end
end

