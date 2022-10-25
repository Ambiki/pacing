require 'spec_helper'
require 'date'

RSpec.describe Pacing::Pacer do
  describe "monthly pacer" do
    it "return some data" do
      school_plan = {
        school_plan_services: [
          {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2023',
            type_of_service: 'Language Therapy',
            frequency: 6,
            interval: 'monthly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 7,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'monthly'
          }, {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2023',
            type_of_service: 'Physical Therapy',
            frequency: 6,
            interval: 'monthly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 2,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'monthly'
          }
        ]
      }

      date = '04-22-2022'
      non_business_days = ['04-25-2022']
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days, mode: :strict).calculate

      expect(results).to eq({
        school_plan_services: [
          {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2023',
            type_of_service: 'Language Therapy',
            frequency: 6,
            interval: 'monthly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 7,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'monthly',
            remaining_visits: 0,
            reset_date: '04-30-2022',
            pace: 2,
            pace_indicator: "🐇"
          }, {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2023',
            type_of_service: 'Physical Therapy',
            frequency: 6,
            interval: 'monthly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 2,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'monthly',
            remaining_visits: 4,
            reset_date: '04-30-2022',
            pace: -3,
            pace_indicator: "🐢"
          }
        ]
      })
    end

    it "should return a positive pacing when more visits are completed than expected before a particular point in time" do
      school_plan = {
        school_plan_services: [
          {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2023',
            type_of_service: 'Speech Therapy',
            frequency: 12,
            interval: 'monthly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 8,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'monthly'
          }, {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2023',
            type_of_service: 'Physical Therapy',
            frequency: 6,
            interval: 'monthly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 4,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'monthly'
          }
        ]
      }

      date = '04-16-2022'
      non_business_days = ['04-25-2022']

      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days, mode: :strict).calculate

      expect(results).to eq(
        {
          school_plan_services: [
            {
              school_plan_type: 'IEP',
              start_date: '04-01-2022',
              end_date: '04-01-2023',
              type_of_service: 'Speech Therapy',
              frequency: 12,
              interval: 'monthly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 8,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'monthly',
              remaining_visits: 4,
              reset_date: '04-30-2022',
              pace: 2,
              pace_indicator: "🐇"
            }, {
              school_plan_type: 'IEP',
              start_date: '04-01-2022',
              end_date: '04-01-2023',
              type_of_service: 'Physical Therapy',
              frequency: 6,
              interval: 'monthly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 4,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'monthly',
              remaining_visits: 2,
              reset_date: '04-30-2022',
              pace: 1,
              pace_indicator: "🐇"
            }
          ]
        })
    end

    it "should return a negative pacing when fewer visits are completed than expected before a particular point in time" do
      school_plan = {
        school_plan_services: [
          {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2023',
            type_of_service: 'Speech Therapy',
            frequency: 12,
            interval: 'monthly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 3,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'monthly'
          }, {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2023',
            type_of_service: 'Physical Therapy',
            frequency: 6,
            interval: 'monthly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 1,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'monthly'
          }
        ]
      }

      date = '04-28-2022'
      non_business_days = ['04-25-2022']
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days, mode: :strict).calculate

      expect(results).to eq(
        {
          school_plan_services: [
            {
              school_plan_type: 'IEP',
              start_date: '04-01-2022',
              end_date: '04-01-2023',
              type_of_service: 'Speech Therapy',
              frequency: 12,
              interval: 'monthly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 3,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'monthly',
              remaining_visits: 9,
              reset_date: '04-30-2022',
              pace: -8,
              pace_indicator: "🐢"
            }, {
              school_plan_type: 'IEP',
              start_date: '04-01-2022',
              end_date: '04-01-2023',
              type_of_service: 'Physical Therapy',
              frequency: 6,
              interval: 'monthly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 1,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'monthly',
              remaining_visits: 5,
              reset_date: '04-30-2022',
              pace: -5,
              pace_indicator: "🐢"
            }
          ]
        }
      )
    end

    it "should return a zero(neutral) pacing when visits completed equal expected visits at a particular point in time" do
      school_plan = {
        school_plan_services: [
          {
            school_plan_type: 'IEP',
            start_date: '05-01-2022',
            end_date: '05-01-2023',
            type_of_service: 'Speech Therapy',
            frequency: 12,
            interval: 'monthly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 6,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'monthly'
          }, {
            school_plan_type: 'IEP',
            start_date: '05-01-2022',
            end_date: '05-01-2023',
            type_of_service: 'Physical Therapy',
            frequency: 6,
            interval: 'monthly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 3,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'monthly'
          }
        ]
      }

      date = '05-16-2022'
      non_business_days = ['05-25-2022']
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days, mode: :strict).calculate

      expect(results).to eq(
        {
          school_plan_services: [
            {
              school_plan_type: 'IEP',
              start_date: '05-01-2022',
              end_date: '05-01-2023',
              type_of_service: 'Speech Therapy',
              frequency: 12,
              interval: 'monthly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 6,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'monthly',
              remaining_visits: 6,
              reset_date: '05-31-2022',
              pace: 0,
              pace_indicator: "😁"
            }, {
              school_plan_type: 'IEP',
              start_date: '05-01-2022',
              end_date: '05-01-2023',
              type_of_service: 'Physical Therapy',
              frequency: 6,
              interval: 'monthly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 3,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'monthly',
              remaining_visits: 3,
              reset_date: '05-31-2022',
              pace: 0,
              pace_indicator: "😁"
            }
          ]
        }
      )
    end
  end

  describe "weekly pacer" do
    it "should return a positive pacing when more visits are completed than expected before a particular point in time" do

      school_plan = {
        school_plan_services: [
          {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2023',
            type_of_service: 'Speech Therapy',
            frequency: 3,
            interval: 'weekly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 2,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'weekly'
          }, {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2023',
            type_of_service: 'Physical Therapy',
            frequency: 2,
            interval: 'weekly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 1,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'weekly'
          }
        ]
      }

      date = '04-16-2022'
      non_business_days = ['04-25-2022']

      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days, mode: :strict).calculate

      expect(results).to eq(
        {
          school_plan_services: [
            {
              school_plan_type: 'IEP',
              start_date: '04-01-2022',
              end_date: '04-01-2023',
              type_of_service: 'Speech Therapy',
              frequency: 3,
              interval: 'weekly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 2,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'weekly',
              remaining_visits: 1,
              reset_date: '04-22-2022',
              pace: 2,
              pace_indicator: "🐇"
            }, {
              school_plan_type: 'IEP',
              start_date: '04-01-2022',
              end_date: '04-01-2023',
              type_of_service: 'Physical Therapy',
              frequency: 2,
              interval: 'weekly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 1,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'weekly',
              remaining_visits: 1,
              reset_date: '04-22-2022',
              pace: 1,
              pace_indicator: "🐇"
            }
          ]
        })
    end

    it "should return a negative pacing when fewer visits are completed than expected before a particular point in time" do
      school_plan = {
        school_plan_services: [
          {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2023',
            type_of_service: 'Speech Therapy',
            frequency: 4,
            interval: 'weekly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 1,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'weekly'
          }, {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2023',
            type_of_service: 'Physical Therapy',
            frequency: 2,
            interval: 'weekly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 0,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'weekly'
          }
        ]
      }

      date = '04-21-2022'
      non_business_days = ['04-25-2022']
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days, mode: :strict).calculate

      expect(results).to eq(
        {
          school_plan_services: [
            {
              school_plan_type: 'IEP',
              start_date: '04-01-2022',
              end_date: '04-01-2023',
              type_of_service: 'Speech Therapy',
              frequency: 4,
              interval: 'weekly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 1,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'weekly',
              remaining_visits: 3,
              reset_date: '04-22-2022',
              pace: -3,
              pace_indicator: "🐢"
            }, {
              school_plan_type: 'IEP',
              start_date: '04-01-2022',
              end_date: '04-01-2023',
              type_of_service: 'Physical Therapy',
              frequency: 2,
              interval: 'weekly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 0,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'weekly',
              remaining_visits: 2,
              reset_date: '04-22-2022',
              pace: -2,
              pace_indicator: "🐢"
            }
          ]
        }
      )
    end

    it "should return a zero(neutral) pacing when visits completed equal expected visits at a particular point in time" do
      school_plan = {
        school_plan_services: [
          {
            school_plan_type: 'IEP',
            start_date: '05-01-2022',
            end_date: '05-01-2023',
            type_of_service: 'Speech Therapy',
            frequency: 4,
            interval: 'weekly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 2,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'weekly'
          }, {
            school_plan_type: 'IEP',
            start_date: '05-01-2022',
            end_date: '05-01-2023',
            type_of_service: 'Physical Therapy',
            frequency: 2,
            interval: 'weekly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 1,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'weekly'
          }
        ]
      }

      date = '05-18-2022'
      non_business_days = ['05-25-2022']
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days, mode: :strict).calculate

      expect(results).to eq(
        {
          school_plan_services: [
            {
              school_plan_type: 'IEP',
              start_date: '05-01-2022',
              end_date: '05-01-2023',
              type_of_service: 'Speech Therapy',
              frequency: 4,
              interval: 'weekly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 2,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'weekly',
              remaining_visits: 2,
              reset_date: '05-22-2022',
              pace: 0,
              pace_indicator: "😁"
            }, {
              school_plan_type: 'IEP',
              start_date: '05-01-2022',
              end_date: '05-01-2023',
              type_of_service: 'Physical Therapy',
              frequency: 2,
              interval: 'weekly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 1,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'weekly',
              remaining_visits: 1,
              reset_date: '05-22-2022',
              pace: 0,
              pace_indicator: "😁"
            }
          ]
        }
      )
    end
  end

  describe "yearly pacer" do
    it "should return a positive pacing when more visits are completed than expected before a particular point in time" do

      school_plan = {
        school_plan_services: [
          {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2025',
            type_of_service: 'Speech Therapy',
            frequency: 12,
            interval: 'yearly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 6,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'yearly'
          }, {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2025',
            type_of_service: 'Physical Therapy',
            frequency: 6,
            interval: 'yearly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 4,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'yearly'
          }
        ]
      }

      date = '08-16-2022'
      non_business_days = ['04-25-2022']

      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days, mode: :strict).calculate

      expect(results).to eq(
        {
          school_plan_services: [
            {
              school_plan_type: 'IEP',
              start_date: '04-01-2022',
              end_date: '04-01-2025',
              type_of_service: 'Speech Therapy',
              frequency: 12,
              interval: 'yearly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 6,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'yearly',
              remaining_visits: 6,
              reset_date: '04-01-2023',
              pace: 1,
              pace_indicator: "🐇"
            }, {
              school_plan_type: 'IEP',
              start_date: '04-01-2022',
              end_date: '04-01-2025',
              type_of_service: 'Physical Therapy',
              frequency: 6,
              interval: 'yearly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 4,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'yearly',
              remaining_visits: 2,
              reset_date: '04-01-2023',
              pace: 2,
              pace_indicator: "🐇"
            }
          ]
        })
    end

    it "should return a negative pacing when fewer visits are completed than expected before a particular point in time" do
      school_plan = {
        school_plan_services: [
          {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2024',
            type_of_service: 'Speech Therapy',
            frequency: 12,
            interval: 'yearly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 2,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'yearly'
          }, {
            school_plan_type: 'IEP',
            start_date: '04-01-2022',
            end_date: '04-01-2024',
            type_of_service: 'Physical Therapy',
            frequency: 6,
            interval: 'yearly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 1,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'yearly'
          }
        ]
      }

      date = '08-15-2022'
      non_business_days = ['04-25-2022']
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days, mode: :strict).calculate

      expect(results).to eq(
        {
          school_plan_services: [
            {
              school_plan_type: 'IEP',
              start_date: '04-01-2022',
              end_date: '04-01-2024',
              type_of_service: 'Speech Therapy',
              frequency: 12,
              interval: 'yearly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 2,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'yearly',
              remaining_visits: 10,
              reset_date: '04-01-2023',
              pace: -2,
              pace_indicator: "🐢"
            }, {
              school_plan_type: 'IEP',
              start_date: '04-01-2022',
              end_date: '04-01-2024',
              type_of_service: 'Physical Therapy',
              frequency: 6,
              interval: 'yearly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 1,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'yearly',
              remaining_visits: 5,
              reset_date: '04-01-2023',
              pace: -1,
              pace_indicator: "🐢"
            }
          ]
        }
      )
    end

    it "should return a zero(neutral) pacing when visits completed equal expected visits at a particular point in time" do
      school_plan = {
        school_plan_services: [
          {
            school_plan_type: 'IEP',
            start_date: '05-01-2022',
            end_date: '05-01-2024',
            type_of_service: 'Speech Therapy',
            frequency: 12,
            interval: 'yearly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 4,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'yearly'
          }, {
            school_plan_type: 'IEP',
            start_date: '05-01-2022',
            end_date: '05-01-2024',
            type_of_service: 'Physical Therapy',
            frequency: 6,
            interval: 'yearly',
            time_per_session_in_minutes: 30,
            completed_visits_for_current_interval: 2,
            extra_sessions_allowable: 1,
            interval_for_extra_sessions_allowable: 'yearly'
          }
        ]
      }

      date = '09-10-2022'
      non_business_days = ['05-25-2022']
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days, mode: :strict).calculate

      expect(results).to eq(
        {
          school_plan_services: [
            {
              school_plan_type: 'IEP',
              start_date: '05-01-2022',
              end_date: '05-01-2024',
              type_of_service: 'Speech Therapy',
              frequency: 12,
              interval: 'yearly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 4,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'yearly',
              remaining_visits: 8,
              reset_date: '05-01-2023',
              pace: 0,
              pace_indicator: "😁"
            }, {
              school_plan_type: 'IEP',
              start_date: '05-01-2022',
              end_date: '05-01-2024',
              type_of_service: 'Physical Therapy',
              frequency: 6,
              interval: 'yearly',
              time_per_session_in_minutes: 30,
              completed_visits_for_current_interval: 2,
              extra_sessions_allowable: 1,
              interval_for_extra_sessions_allowable: 'yearly',
              remaining_visits: 4,
              reset_date: '05-01-2023',
              pace: 0,
              pace_indicator: "😁"
            }
          ]
        }
      )
    end
  end

  describe 'error handling' do
    it "should respond with friendly error message for a misformed date" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '22-1-2022'
      non_business_days = ['25-1-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('The date should be formatted as a string in the format mm-dd-yyyy')
    end

    it "should respond with friendly error message for a misformed date" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '22-1-2022'
      non_business_days = ['25-1-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error(TypeError)
    end

    it "should respond with a friendly error message if no date is passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = nil
      non_business_days = ['25-01-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('You must pass in a date')
    end

    it "should respond with a friendly error message if date is out of range of school plan service start and end date" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '04-01-2018'
      non_business_days = ['25-01-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Date must be within the interval range of the school plan')
    end

    it "should respond with friendly error message for a misformed date for non-business-days" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '04-22-2022'
      non_business_days = ['25-1-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('"Non business days" dates should be formatted as a string in the format mm-dd-yyyy')
    end

    it "should respond with friendly error message for a misformed date for non-business-days if there is an array of dates" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '04-22-2022'
      non_business_days = ['25-1-2022', '04-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('"Non business days" dates should be formatted as a string in the format mm-dd-yyyy')
    end

    it "should respond with friendly error message if there is no school plan passed in" do
      school_plan = nil
      date = '04-22-2022'
      non_business_days = ['04-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('You must pass in at least one school plan')
    end

    it "should respond with a friendly error message if the school plan is not passed in as a hash" do
      school_plan = 1
      date = '04-22-2022'
      non_business_days = ['04-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('School plan must be a hash')
    end

    it "should respond with friendly error message for a misformed date in the school plan service" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '13-01-2022', end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '04-22-2022'
      non_business_days = ['04-01-2022', '04-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('School plan services start and end dates should be formatted as a string in the format mm-dd-yyyy')
    end

    it "should respond with friendly error message if no start or end date is passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: nil, end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '04-22-2022'
      non_business_days = ['04-01-2022', '04-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('School plan services start and end dates can not be nil')
    end

    it "should respond with friendly error message if school plan type is not a string or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 1, start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '04-22-2022'
      non_business_days = ['04-01-2022', '04-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('School plan type must be a string and cannot be nil')
    end

    it "should respond with friendly error message if type of service is not a string or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: nil, frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '04-22-2022'
      non_business_days = ['04-01-2022', '04-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Type of service must be a string and cannot be nil')
    end

    it "should respond with friendly error message if frequency is not an integer or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 'six', interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '04-22-2022'
      non_business_days = ['04-01-2022', '04-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Frequency must be an integer and cannot be nil')
    end

    it "should respond with friendly error message if interval is not a string or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: nil, time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '04-22-2022'
      non_business_days = ['04-01-2022', '04-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Interval must be a string and cannot be nil')
    end

    it "should respond with friendly error message if time per session in minutes is not an integer or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 'thirty', completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '04-22-2022'
      non_business_days = ['04-01-2022', '04-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Time per session in minutes must be an integer and cannot be nil')
    end

    it "should respond with friendly error message if completed visits for current interval is not an integer or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 'seven', extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '04-22-2022'
      non_business_days = ['04-01-2022', '04-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Completed visits for current interval must be an integer and cannot be nil')
    end

    it "should respond with friendly error message if extra sessionss allowable is not an integer or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 'one', interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '04-22-2022'
      non_business_days = ['04-01-2022', '04-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Extra sessions allowable must be an integer and cannot be nil')
    end

    it "should respond with friendly error message if interval for extra sessions allowable is not a string or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: nil }, {school_plan_type: 'IEP', start_date: '04-01-2022', end_date: '04-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '04-22-2022'
      non_business_days = ['04-01-2022', '04-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Interval for extra sessions allowable must be a string and cannot be nil')
    end

  end

  describe 'Cue specs' do

    it "should correctly parse the pacing for patient 17" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 23" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech and Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 28" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-18-2022", :end_date=>"01-18-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 35" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"11-01-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 50" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-03-2022", :end_date=>"02-03-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-03-2022", :end_date=>"02-03-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 51" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 72" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 86" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 103" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 109" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 115" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-19-2022", :end_date=>"04-19-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 123" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-01-2022", :end_date=>"10-30-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 135" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-06-2022", :end_date=>"04-06-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>55, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>34, :used_visits=>55, :pace=>17, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>38, :reset_date=>"04-06-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 146" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-20-2021", :end_date=>"10-20-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 148" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>3, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 166" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Language Therapy", :remaining_visits=>26, :used_visits=>4, :pace=>2, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"09-27-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 174" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-10-2022", :end_date=>"08-10-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Language Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 190" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 191" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-14-2022", :end_date=>"03-13-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 200" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 206" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 213" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-28-2022", :end_date=>"01-28-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 265" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"10-27-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 266" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-25-2022", :end_date=>"02-24-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 267" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-09-2021", :end_date=>"11-09-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 281" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 284" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>3, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 290" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-04-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 293" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 307" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Language Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 318" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-24-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 320" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 325" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 332" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>60, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>48, :used_visits=>60, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>62, :reset_date=>"03-24-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 344" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 399" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 418" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-25-2022", :end_date=>"02-25-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>89, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>19, :used_visits=>89, :pace=>19, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>74, :reset_date=>"02-25-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 426" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 431" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 450" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 456" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 480" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"08-31-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 507" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-02-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 515" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 516" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 523" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 542" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 544" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-01-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>1, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 545" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-19-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Language Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 547" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 557" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-02-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>3, :pace=>1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>3, :pace=>1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 558" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 561" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 567" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 576" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 585" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 602" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>4, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 608" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-23-2021", :end_date=>"11-23-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 614" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 642" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 643" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"07-29-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 644" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>74, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>105, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"09-30-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 652" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 661" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 663" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-18-2022", :end_date=>"03-18-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 707" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 714" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"10-06-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"10-06-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 715" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"09-01-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 722" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 731" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 738" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 740" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-08-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 748" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-10-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 752" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 753" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 765" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 780" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-14-2022", :end_date=>"03-14-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-14-2022", :end_date=>"03-14-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>14, :used_visits=>2, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 795" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-26-2022", :end_date=>"05-26-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 802" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 812" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-09-2021", :end_date=>"11-09-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>102, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"11-09-2021", :end_date=>"11-09-2022", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>102, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>19, :used_visits=>89, :pace=>-12, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>101, :reset_date=>"11-09-2022"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>31, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>30, :reset_date=>"11-09-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 815" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 819" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"10-06-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 833" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"11-05-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 841" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 883" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 890" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 892" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>35, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>61, :used_visits=>9, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>10, :reset_date=>"08-29-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 911" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>55, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>104, :used_visits=>4, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"09-29-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 927" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-21-2022", :end_date=>"01-21-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 931" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>88, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>88, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>116, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"09-28-2023"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>40, :used_visits=>2, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"09-28-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 937" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 938" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-28-2022", :end_date=>"01-28-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 939" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 940" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 945" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 946" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 947" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 951" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>66, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>66, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>105, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"09-29-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 973" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 977" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-05-2021", :end_date=>"11-05-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 985" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"02-22-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 993" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1002" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1033" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1035" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1048" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1077" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-26-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-26-2022", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-26-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}[0][:pace], {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}[0][:pace], {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1092" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>98, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>98, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>17, :used_visits=>91, :pace=>-16, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>107, :reset_date=>"10-19-2022"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>31, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>32, :reset_date=>"10-19-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1094" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1107" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1120" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1138" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-07-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-07-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1144" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1160" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1172" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1175" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1185" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>69, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>69, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>69, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>56, :used_visits=>52, :pace=>-42, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>94, :reset_date=>"12-01-2022"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>10, :used_visits=>22, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>28, :reset_date=>"12-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1193" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"12-07-2022", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>68, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"12-07-2022", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>68, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>96, :used_visits=>22, :pace=>-66, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>88, :reset_date=>"12-07-2022"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>36, :used_visits=>6, :pace=>-25, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>31, :reset_date=>"12-07-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1204" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1210" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2023", :end_date=>"06-30-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1223" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1228" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1229" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1235" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1239" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1283" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1285" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}[0][:pace], {:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1287" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>4, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1293" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"03-16-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"03-16-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"07-29-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"07-29-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1298" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1313" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-17-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-17-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1314" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-13-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>4, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1316" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-29-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1317" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1338" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-05-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>69, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>39, :used_visits=>69, :pace=>-15, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>84, :reset_date=>"01-05-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1345" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>109, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>109, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>115, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"09-29-2023"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>40, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"09-29-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1351" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1361" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1368" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-11-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-11-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1376" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1377" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1391" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"05-12-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1393" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-03-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-03-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}[0][:pace], {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}[0][:pace], {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1413" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1418" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-02-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1420" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1435" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-10-2022", :end_date=>"10-10-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-10-2022", :end_date=>"10-10-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1479" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1494" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-22-2021", :end_date=>"10-21-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1500" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-22-2021", :end_date=>"10-21-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"10-22-2021", :end_date=>"10-21-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}[0][:pace], {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1513" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-17-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-17-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1514" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>97, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>97, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>105, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"10-03-2023"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>31, :used_visits=>1, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-03-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1518" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"05-19-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"04-08-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1528" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1533" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1547" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-21-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-21-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1550" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1553" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1561" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"07-29-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"07-29-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1566" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-12-2020", :end_date=>"09-12-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1574" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1581" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1582" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1583" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1596" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-16-2021", :end_date=>"12-16-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1609" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>39, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>53, :used_visits=>27, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>34, :reset_date=>"05-16-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1610" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>37, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>52, :used_visits=>28, :pace=>-8, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>36, :reset_date=>"05-05-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1612" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1638" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-11-2021", :end_date=>"11-11-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>70, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>30, :used_visits=>78, :pace=>-22, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>100, :reset_date=>"11-11-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1640" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1652" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>79, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>95, :used_visits=>13, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>12, :reset_date=>"09-07-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1656" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>16, :used_visits=>3, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>10, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1678" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"02-08-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"02-08-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1680" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1681" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-20-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1693" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"03-25-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>77, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>68, :used_visits=>50, :pace=>-16, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>66, :reset_date=>"03-25-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1710" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1726" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1736" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-11-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-11-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1738" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-19-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1772" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1773" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1777" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"03-03-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1787" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-23-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-23-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1793" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1797" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1804" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-23-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1819" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1824" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1842" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1856" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1861" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1902" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>52, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>52, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>93, :used_visits=>15, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>15, :reset_date=>"08-29-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1909" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-18-2022", :end_date=>"09-17-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-14-2022", :end_date=>"07-07-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"03-04-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1943" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1950" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-02-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1958" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>83, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>83, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>89, :used_visits=>19, :pace=>4, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>15, :reset_date=>"08-26-2023"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>27, :used_visits=>5, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"08-26-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1963" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1973" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-28-2022", :end_date=>"02-18-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-28-2022", :end_date=>"02-18-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"05-27-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"05-27-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1980" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1981" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1983" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1987" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 1998" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-04-2022", :end_date=>"10-04-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>107, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"10-04-2022", :end_date=>"10-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>107, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>116, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"10-04-2023"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>40, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"10-04-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2014" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2019" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-22-2023", :type_of_service=>"Language Therapy", :frequency=>16, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-25-2022", :end_date=>"06-23-2022", :type_of_service=>"Language Therapy", :frequency=>16, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>16, :used_visits=>0, :pace=>-8, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2023" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2036" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-02-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-02-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2052" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>63, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>63, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>70, :used_visits=>38, :pace=>-18, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>56, :reset_date=>"04-11-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2057" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>69, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>69, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>70, :used_visits=>38, :pace=>-39, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>77, :reset_date=>"01-31-2023"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>9, :used_visits=>23, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>23, :reset_date=>"01-31-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2058" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2061" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2070" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2079" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2102" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2124" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-04-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2129" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>75, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>103, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"09-28-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2144" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-06-2021", :end_date=>"12-06-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-06-2021", :end_date=>"12-06-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"07-31-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"07-31-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2154" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2168" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-13-2022", :end_date=>"01-13-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2185" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>69, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>69, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>104, :used_visits=>14, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>13, :reset_date=>"09-07-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2193" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2198" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2200" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-26-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>68, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>21, :used_visits=>87, :pace=>-18, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>105, :reset_date=>"10-26-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2205" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"02-11-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"02-11-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"06-22-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"06-22-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2210" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"07-29-2022", :end_date=>"07-29-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2221" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>12, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>101, :used_visits=>7, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"09-22-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2222" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"07-29-2022", :end_date=>"07-29-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2225" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2229" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2261" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2264" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-01-2021", :end_date=>"11-01-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-01-2021", :end_date=>"11-01-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2267" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"04-04-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2270" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2278" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2286" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"05-20-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"05-20-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2290" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2292" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2299" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2303" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-19-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2305" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-25-2021", :end_date=>"10-25-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2314" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}[0][:pace], {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2319" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-14-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2324" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"01-21-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"01-21-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2327" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2331" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Speech Therapy", :frequency=>40, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>61, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>20, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>61, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>68, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"09-28-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2348" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2351" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-26-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2357" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-04-2021", :end_date=>"11-04-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>83, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>97, :pace=>-5, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>102, :reset_date=>"11-04-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2376" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-02-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>64, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>54, :used_visits=>64, :pace=>-39, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>103, :reset_date=>"12-02-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2377" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"04-13-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2388" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2389" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-20-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2394" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2411" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"07-31-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"07-31-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2412" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2424" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-12-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-12-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2425" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2426" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2445" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"01-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2458" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-06-2021", :end_date=>"12-06-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-06-2021", :end_date=>"12-06-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2460" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2492" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2494" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2499" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-06-2021", :end_date=>"12-06-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2508" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2509" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2515" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"07-30-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2541" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2543" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-27-2021", :end_date=>"10-27-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2551" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2552" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-03-2022", :end_date=>"02-03-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2560" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-07-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2570" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-20-2021", :end_date=>"10-20-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2578" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}[0][:pace], {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2604" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-10-2022", :end_date=>"01-10-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-14-2022", :end_date=>"07-07-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2608" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-13-2022", :end_date=>"01-13-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2614" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2617" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"03-02-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>108, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"03-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>108, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>66, :used_visits=>42, :pace=>-20, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>62, :reset_date=>"03-02-2023"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>17, :used_visits=>15, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>18, :reset_date=>"03-02-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2620" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2626" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-14-2022", :end_date=>"02-14-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-14-2022", :end_date=>"02-14-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2627" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2636" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-04-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2642" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>64, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>54, :used_visits=>16, :pace=>6, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>10, :reset_date=>"08-29-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2650" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"01-28-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2659" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2665" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"03-30-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2667" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>69, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>83, :used_visits=>25, :pace=>-22, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>47, :reset_date=>"05-10-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2678" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-27-2021", :end_date=>"10-27-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-27-2021", :end_date=>"10-27-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>45, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2698" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2699" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2706" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-29-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-29-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2707" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-22-2021", :end_date=>"10-22-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2715" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-23-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2716" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-23-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2721" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"01-13-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2725" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2729" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2730" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2737" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2738" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"01-19-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"01-19-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2739" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2750" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2769" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2782" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2783" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>97, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>97, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>89, :used_visits=>19, :pace=>3, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>16, :reset_date=>"08-24-2023"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>27, :used_visits=>5, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"08-24-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2800" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"05-20-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"12-16-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2859" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-18-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-18-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2861" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-17-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2878" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-19-2022", :end_date=>"04-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2885" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2897" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2908" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-18-2022", :end_date=>"08-18-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2911" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-18-2022", :end_date=>"08-18-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2918" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-04-2022", :end_date=>"05-19-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2950" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2977" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>4, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2984" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2990" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-25-2022", :end_date=>"02-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 2999" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>106, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>113, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"09-28-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3001" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3002" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3003" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Language Therapy", :frequency=>16, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>114, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>14, :used_visits=>3, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"11-01-2022"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>13, :used_visits=>29, :pace=>-3, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>32, :reset_date=>"01-14-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3009" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"03-15-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3022" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>63, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>52, :used_visits=>56, :pace=>-21, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>77, :reset_date=>"01-27-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3041" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>79, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>79, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>92, :used_visits=>26, :pace=>-27, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>53, :reset_date=>"05-05-2023"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>29, :used_visits=>13, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>19, :reset_date=>"05-05-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3049" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-13-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3059" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-20-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3076" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3088" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}[0][:pace], {:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3111" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"04-27-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"04-27-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3118" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-22-2021", :end_date=>"10-22-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3119" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3120" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3132" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"11-15-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-27-2022", :end_date=>"06-22-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3134" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-19-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3136" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3144" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3147" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3163" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3164" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3177" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"07-31-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-27-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3183" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3185" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3199" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3205" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-17-2021", :end_date=>"12-17-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-17-2021", :end_date=>"12-17-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}[0][:pace], {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3210" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3218" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-09-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3223" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-16-2022", :end_date=>"06-16-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3240" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3242" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-19-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3245" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-20-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3253" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3258" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3261" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"07-01-2022", :end_date=>"11-15-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3283" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3287" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"03-21-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"03-21-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3294" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3302" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"03-04-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>56, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>90, :used_visits=>28, :pace=>-33, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>61, :reset_date=>"03-04-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3306" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3307" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3319" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"02-21-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3333" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3339" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>55, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>55, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>115, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"09-30-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>41, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"09-30-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3341" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"03-31-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3363" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3391" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3398" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3423" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"08-15-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3437" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-20-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3447" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>107, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>16, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>107, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>102, :used_visits=>6, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"09-27-2023"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>15, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"09-27-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3469" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-15-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3472" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"07-29-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3482" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3497" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3511" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3516" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3523" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3533" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3541" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-17-2021", :end_date=>"12-17-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3553" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3567" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3571" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-19-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3572" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"04-26-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"04-26-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3590" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-21-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-21-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3595" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>30, :used_visits=>0, :pace=>-26, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>26, :reset_date=>"12-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3600" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"03-16-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3610" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-11-2022", :end_date=>"08-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-11-2022", :end_date=>"08-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3612" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3616" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>104, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>104, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>103, :used_visits=>5, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"09-29-2023"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>31, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"09-29-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3617" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3664" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3665" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-18-2022", :end_date=>"03-18-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3687" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-17-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-17-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3690" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3695" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3701" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-22-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-22-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-25-2022", :end_date=>"07-29-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-25-2022", :end_date=>"07-29-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3703" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3704" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3707" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-17-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-17-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-25-2022", :end_date=>"06-22-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-25-2022", :end_date=>"06-22-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3714" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3814" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3815" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"03-06-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3816" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3821" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3822" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3824" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3827" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-26-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-26-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3828" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3829" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"10-06-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3834" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3837" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3842" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3844" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3895" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-14-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-14-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3897" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-08-2022", :end_date=>"08-08-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3898" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3904" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3946" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-05-2021", :end_date=>"11-05-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3951" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 3958" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"11-17-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"11-17-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}[0][:pace], {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4012" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4016" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4022" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}[0][:pace], {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4026" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-18-2021", :end_date=>"10-18-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4031" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4032" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4035" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-09-2021", :end_date=>"11-09-2022", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>51, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>49, :used_visits=>59, :pace=>-42, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>101, :reset_date=>"11-09-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4038" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-09-2021", :end_date=>"11-09-2022", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>17, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>84, :used_visits=>24, :pace=>-77, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>101, :reset_date=>"11-09-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4044" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-26-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4048" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4055" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4056" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-02-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>52, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>103, :used_visits=>15, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>14, :reset_date=>"09-02-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4058" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-28-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4070" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-15-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-15-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4072" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-17-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4078" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4085" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-09-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4088" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-03-2022", :end_date=>"02-03-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-03-2022", :end_date=>"02-03-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4096" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4100" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4102" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-03-2022", :type_of_service=>"Speech and Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4108" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>5, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4114" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"03-20-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4122" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4123" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-11-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-11-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4130" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-13-2022", :end_date=>"01-13-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4133" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"10-06-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4147" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"03-31-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"03-31-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4150" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>93, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>79, :used_visits=>29, :pace=>-17, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>46, :reset_date=>"05-16-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4151" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4163" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-17-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-17-2023", :type_of_service=>"Speech Therapy", :frequency=>10, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-17-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>3, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4170" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>81, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>81, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>18, :used_visits=>90, :pace=>-8, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>98, :reset_date=>"11-18-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4180" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>90, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>96, :used_visits=>22, :pace=>-28, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>50, :reset_date=>"05-16-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4181" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4195" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4197" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4198" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-18-2022", :end_date=>"03-18-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4200" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-15-2022", :end_date=>"03-15-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4201" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"02-04-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4207" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4216" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"07-31-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"12-03-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4218" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4220" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4221" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>1, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4224" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4230" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-06-2022", :end_date=>"07-28-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4231" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4232" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-18-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-18-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4235" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-25-2022", :end_date=>"02-24-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4236" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4253" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4254" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4258" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-25-2022", :end_date=>"06-22-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4261" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-22-2021", :end_date=>"11-22-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4264" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4266" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-14-2022", :end_date=>"02-14-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4276" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-18-2022", :end_date=>"08-18-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4285" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-15-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4286" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4288" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4289" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4292" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>80, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>80, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>78, :used_visits=>40, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>54, :reset_date=>"05-04-2023"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4297" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"11-02-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4304" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>3, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4305" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4308" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-20-2021", :end_date=>"10-19-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4310" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"02-21-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"02-21-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4312" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-18-2022", :end_date=>"01-31-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4318" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4327" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-19-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4328" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4332" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4338" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4341" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4344" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4348" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4349" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4355" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4361" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-14-2022", :end_date=>"02-14-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4379" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4381" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4388" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4407" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4419" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-02-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4446" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-21-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4459" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2021", :end_date=>"10-18-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4460" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"04-14-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4463" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4464" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4465" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4468" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4491" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-18-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4498" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4512" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4514" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"05-23-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"05-23-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4531" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4553" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-19-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-19-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}][0][:pace])
    end

    it "should correctly parse the pacing for patient 4557" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-04-2022", :end_date=>"01-04-2023", :type_of_service=>"Language Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results[:school_plan_services][0][:pace]).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>43, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>43, :reset_date=>"01-04-2023"}][0][:pace])
    end
  end
end