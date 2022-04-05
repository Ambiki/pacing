module Pacing
  class Pacer
    attr_reader :iep_interval, :date
    def initialize(iep:, date:, non_business_days:)
      @iep = iep
      @date = date
      @non_business_days = non_business_days
    end

    #  iep_interval = 12
    #  date = '22-1-2022'
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
      return {iep_service: [{start_date: '1-01-22', end_date: '1-01-23', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: '1 per month', remaining_visits: 0, reset_date: '31-01-2022', pace: 4, pace_indicator: "🐇" }, {start_date: '1-01-22', end_date: '1-01-23', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: '1 per month', remaining_visits: 0, reset_date: '31-01-2022', pace: 4, pace_indicator: "🐇" }]}
    end

  end
end