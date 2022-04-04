module Pacing
  class Pacer
    attr_reader :iep_interval, :date
    def initialize(iep:, date:)
      @iep = iep
      @date = date
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

    iep = {
      iep {
        start_date:
        end_date:
        iep_services: {
          [
            {
              start_date:
              end_date:
              type_of_service: "Speech"
              frequency: 2
              interval: "monthly"
              time_per_session: 30,
              completed_visits_for_current_interval: 5
            },
            {
              start_date:
              end_date:
              type_of_service: "Physical"
              frequency: 2
              interval: "monthly"
              time_per_session: 30,
              completed_visits_for_current_interval: 3
            },
          ]
        }
      }

    }

    def calculate
      return { "remaining_visits" => 3, "reset_date" => '31-01-2022', "pace" => 4, "pace_indicator" => "🐇"}
    end

  end
end