module Pacing
  class Pacer
    attr_reader :school_plan, :date, :non_business_days
    def initialize(school_plan:, date:, non_business_days:)
      @school_plan = school_plan
      raise ArgumentError.new("You must pass in at least one school plan") if @school_plan.nil?
      raise TypeError.new("School plan must be a hash") if @school_plan.class != Hash
      @date = date
      raise ArgumentError.new('You must pass in a date') if @date.nil?
      raise TypeError.new("The date should be formatted as a string in the format mm-dd-yyyy") if @date.class != String || !/(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])-(19|20)\d\d/.match?(@date)
      @non_business_days = non_business_days
      raise ArgumentError.new('You must pass in a non_business_day') if @non_business_days.empty?
      @non_business_days.each do |non_business_day|
        raise TypeError.new('"Non business days" dates should be formatted as a string in the format mm-dd-yyyy') if non_business_day.class != String || !/(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])-(19|20)\d\d/.match?(non_business_day)
      end
      @school_plan[:school_plan_services].each do |school_plan_service|
        raise TypeError.new("School plan services start and end dates should be formatted as a string in the format mm-dd-yyyy") if school_plan_service[:start_date].class != String || !/(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])-(19|20)\d\d/.match?(school_plan_service[:start_date])
        raise TypeError.new("School plan services start and end dates should be formatted as a string in the format mm-dd-yyyy") if school_plan_service[:end_date].class != String || !/(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])-(19|20)\d\d/.match?(school_plan_service[:end_date])
      end
    end

    #  iep_interval = 12
    #  date = '01-22-2022'
    #  duration = 20
    #  completed_visits = 14

    # TODO Missing Data
    # IEP reset date
    # Frequency (weekly, monthly)


    # IEP visits allowed per the period
    # How many visits have happened in the period


    # IEP (parent)

      # IEP Services
        # Service A (discipline, 2Wx30)
        # Service B (3Mx30)
        # Service C (4Mx20)

    def calculate
      return {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1 , interval_for_extra_sesssions_allowable: 'monthly', remaining_visits: 0, reset_date: '01-31-2022', pace: 4, pace_indicator: "🐇" }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1 , interval_for_extra_sesssions_allowable: 'monthly', remaining_visits: 0, reset_date: '01-31-2022', pace: 4, pace_indicator: "🐇" }]}
    end

  end
end