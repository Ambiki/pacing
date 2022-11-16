require 'date'
require 'holidays'

# visits are for all(summation)
# frequencies should be normalized(should be summed for one)(normalize towards month)
# pacing should be calculated on the discipline
# normalize also based on time per session

module Pacing
  # two modes(strict: use start dates strictly in calculating pacing)
  class Normalizer

    attr_accessor :services, :date

    def initialize(services, date)
      @date = date
      @services = active_services(services)
    end

    def normalize
      { school_plan_services: disciplines_cleaner([speech_discipline, occupational_discipline, physical_discipline, feeding_discipline]) }
    end

    def speech_discipline
      discipline = {
        :school_plan_type => 'IEP',
        :start_date => "01-01-2100", # some arbitrary start date
        :end_date => "01-01-2000", # some arbitrary end date
        :type_of_service => 'Speech Therapy',
        :frequency => 0,
        :interval => '',
        :time_per_session_in_minutes => 0,
        :completed_visits_for_current_interval => 0,
        :extra_sessions_allowable => 0,
        :interval_for_extra_sessions_allowable => ''
      }

      discipline_services = services.filter do |service|
        ["pragmatic language", "speech and language", "language", "speech", "language therapy", "speech therapy", "speech and language therapy", "speech language therapy"].include?(service[:type_of_service].downcase)
      end
      
      return {} if discipline_services.empty?

      discipline_services = normalize_to_monthly_frequency(discipline_services)

      discipline_data(discipline_services, discipline)
    end

    def occupational_discipline
      discipline = {
        :school_plan_type => 'IEP',
        :start_date => "01-01-2100", # some arbitrary start date
        :end_date => "01-01-2000", # some arbitrary end date
        :type_of_service => 'Occupational Therapy',
        :frequency => 0,
        :interval => '',
        :time_per_session_in_minutes => 0,
        :completed_visits_for_current_interval => 0,
        :extra_sessions_allowable => 0,
        :interval_for_extra_sessions_allowable => ''
      }

      discipline_services = services.filter do |service|
        ["occupation therapy", "occupational therapy"].include?(service[:type_of_service].downcase)
      end
      
      return {} if discipline_services.empty?

      discipline_services = normalize_to_monthly_frequency(discipline_services)

      discipline_data(discipline_services, discipline)
    end

    def physical_discipline
      discipline = {
        :school_plan_type => 'IEP',
        :start_date => "01-01-2100", # some arbitrary start date
        :end_date => "01-01-2000", # some arbitrary end date
        :type_of_service => 'Physical Therapy',
        :frequency => 0,
        :interval => '',
        :time_per_session_in_minutes => 0,
        :completed_visits_for_current_interval => 0,
        :extra_sessions_allowable => 0,
        :interval_for_extra_sessions_allowable => ''
      }

      discipline_services = services.filter do |service|
        ["physical therapy"].include?(service[:type_of_service].downcase)
      end
      
      return {} if discipline_services.empty?

      discipline_services = normalize_to_monthly_frequency(discipline_services)

      discipline_data(discipline_services, discipline)
    end

    def feeding_discipline
      discipline = {
        :school_plan_type => 'IEP',
        :start_date => "01-01-2100", # some arbitrary start date
        :end_date => "01-01-2000", # some arbitrary end date
        :type_of_service => 'Feeding Therapy',
        :frequency => 0,
        :interval => '',
        :time_per_session_in_minutes => 0,
        :completed_visits_for_current_interval => 0,
        :extra_sessions_allowable => 0,
        :interval_for_extra_sessions_allowable => ''
      }

      discipline_services = services.filter do |service|
        ["feeding therapy"].include?(service[:type_of_service].downcase)
      end
      
      return {} if discipline_services.empty?

      discipline_services = normalize_to_monthly_frequency(discipline_services)

      discipline_data(discipline_services, discipline)
    end

    def discipline_data(services, discipline)
      # school_plan_type: 'IEP',
      # start_date: '04-01-2022', -
      # end_date: '04-01-2023', - 
      # type_of_service: 'Speech Therapy', -
      # frequency: 4, -
      # interval: 'weekly', -
      # time_per_session_in_minutes: 30, -
      # completed_visits_for_current_interval: 0, -
      # extra_sessions_allowable: 1, -
      # interval_for_extra_sessions_allowable: 'weekly' -

      services.each do |service|
        discipline[:start_date] = parse_date(service[:start_date]) < parse_date(discipline[:start_date]) ? service[:start_date] : discipline[:start_date]

        discipline[:end_date] = parse_date(service[:end_date]) > parse_date(discipline[:end_date]) ? service[:end_date] : discipline[:end_date]

        discipline[:frequency] += service[:frequency].to_i

        discipline[:completed_visits_for_current_interval] = service[:completed_visits_for_current_interval]

        discipline[:time_per_session_in_minutes] = service[:time_per_session_in_minutes] > discipline[:time_per_session_in_minutes] ? service[:time_per_session_in_minutes] : discipline[:time_per_session_in_minutes]

        discipline[:interval] = service[:interval]

        discipline[:extra_sessions_allowable] += service[:extra_sessions_allowable].to_i

        discipline[:interval_for_extra_sessions_allowable] = service[:interval_for_extra_sessions_allowable]
      end

      discipline
    end

    def same_interval(services)
      interval = services[0].nil? ? "" : services[0][:interval]
      same = true

      services.each do |service|
        if interval != service[:interval]
          # puts "this happened for real? interval #{interval} and service interval #{service[:interval]} #{services}"
          same = false
        end
      end

      same
    end

    def normalize_to_monthly_frequency(services)
      interval_average_days = {
        "weekly" => 5,
        "monthly" => 20,
        "yearly" => 200
      }

      return services if same_interval(services)

      services.map do |service|
        if !(service[:interval] == "monthly")
          # weekly(5 days) = frequency # weekly
          # monthly(20 days) = frequency * monthly 
          # yearly(200 days)

          f = service[:frequency]

          service[:frequency] = ((service[:frequency] * interval_average_days["monthly"].to_f) / interval_average_days[service[:interval]]).round

          puts "from interval #{service[:interval]} to monthly and frequency #{service[:frequency]} to frequency #{f}"

          service[:interval] = "monthly"
        end

        service
      end

      services
    end

    def parse_date(date)
      begin
        Date.strptime(date, '%m-%d-%Y')
      rescue => exception
      end
    end

    def disciplines_cleaner(disciplines)
      # use the fake arbitrary reset date to remove unrequired disciplines
      disciplines.filter { |discipline| !discipline.empty? }
    end

    def active_services(services)
      services.filter do |school_plan_service|
        within = true
        begin
          if !(parse_date(school_plan_service[:start_date]) <= parse_date(date) && parse_date(date) <= parse_date(school_plan_service[:end_date]))
            within = false
          end
        rescue => exception
        end

        within
      end
    end
  end
end

