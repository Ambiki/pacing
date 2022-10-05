require 'spec_helper'
require 'date'

RSpec.describe Pacing::Pacer do
  describe '#new' do
    it "return some data" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-22-2022'
      non_business_days = ['01-25-2022']
      expect(Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate).to eq({school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly', remaining_visits: 0, reset_date: '01-31-2022', pace: 4, pace_indicator: "🐇" }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly', remaining_visits: 0, reset_date: '01-31-2022', pace: 4, pace_indicator: "🐇" }]})
    end

    it "positive" do
      # some ideas
      # fix pacing definition and formula
      # fix date format
      # Pace = actual visits at point in time - expected visits to meet frequency at that point in time 6 -6

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
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Speech Therapy', frequency: 12, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 8, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 4, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-16-2022'
      non_business_days = ['01-25-2022']

      expect(Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate).to eq({school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Speech Therapy', frequency: 12, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly', remaining_visits: 6, reset_date: '01-31-2022', pace: 2, pace_indicator: "🐇" }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 4, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly', remaining_visits: 2, reset_date: '01-31-2022', pace: 1, pace_indicator: "🐇" }]})
    end

    it "negative pacing" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Speech Therapy', frequency: 12, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 6, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 1, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-28-2022'
      non_business_days = ['01-25-2022']

      expect(Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate).to eq({school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Speech Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 1, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly', remaining_visits: 5, reset_date: '01-31-2022', pace: -4, pace_indicator: "🐇" }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 4, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly', remaining_visits: 2, reset_date: '01-31-2022', pace: 1, pace_indicator: "🐇" }]})
    end

    it "neutral pacing(0)" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Speech Therapy', frequency: 12, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 6, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 3, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-16-2022'
      non_business_days = ['01-25-2022']

      expect(Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate).to eq({school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Speech Therapy', frequency: 12, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 6, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly', remaining_visits: 6, reset_date: '01-31-2022', pace: 0, pace_indicator: "🐇" }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 3, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly', remaining_visits: 3, reset_date: '01-31-2022', pace: 0, pace_indicator: "🐇" }]})
    end
  end

  describe 'error handling' do
    it "should respond with friendly error message for a misformed date" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '22-1-2022'
      non_business_days = ['25-1-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('The date should be formatted as a string in the format mm-dd-yyyy')
    end

    it "should respond with friendly error message for a misformed date" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '22-1-2022'
      non_business_days = ['25-1-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error(TypeError)
    end

    it "should respond with a friendly error message if no date is passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = nil
      non_business_days = ['25-01-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('You must pass in a date')
    end

    it "should respond with friendly error message for a misformed date for non-business-days" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-22-2022'
      non_business_days = ['25-1-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('"Non business days" dates should be formatted as a string in the format mm-dd-yyyy')
    end

    it "should respond with friendly error message for a misformed date for non-business-days if there is an array of dates" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-22-2022'
      non_business_days = ['25-1-2022', '01-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('"Non business days" dates should be formatted as a string in the format mm-dd-yyyy')
    end

    it "should respond with friendly error message if there is no school plan passed in" do
      school_plan = nil
      date = '01-22-2022'
      non_business_days = ['01-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('You must pass in at least one school plan')
    end

    it "should respond with a friendly error message if the school plan is not passed in as a hash" do
      school_plan = 1
      date = '01-22-2022'
      non_business_days = ['01-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('School plan must be a hash')
    end

    it "should respond with friendly error message for a misformed date in the school plan service" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '13-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-22-2022'
      non_business_days = ['01-01-2022', '01-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('School plan services start and end dates should be formatted as a string in the format mm-dd-yyyy')
    end

    it "should respond with friendly error message if no start or end date is passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: nil, end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-22-2022'
      non_business_days = ['01-01-2022', '01-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('School plan services start and end dates can not be nil')
    end

    it "should respond with friendly error message if school plan type is not a string or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 1, start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-22-2022'
      non_business_days = ['01-01-2022', '01-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('School plan type must be a string and cannot be nil')
    end

    it "should respond with friendly error message if type of service is not a string or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: nil, frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-22-2022'
      non_business_days = ['01-01-2022', '01-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Type of service must be a string and cannot be nil')
    end
    
    it "should respond with friendly error message if frequency is not an integer or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 'six', interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-22-2022'
      non_business_days = ['01-01-2022', '01-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Frequency must be an integer and cannot be nil')
    end

    it "should respond with friendly error message if interval is not a string or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: nil, time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-22-2022'
      non_business_days = ['01-01-2022', '01-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Interval must be a string and cannot be nil')
    end

    it "should respond with friendly error message if time per session in minutes is not an integer or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 'thirty', completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-22-2022'
      non_business_days = ['01-01-2022', '01-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Time per session in minutes must be an integer and cannot be nil')
    end

    it "should respond with friendly error message if completed visits for current interval is not an integer or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 'seven', extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-22-2022'
      non_business_days = ['01-01-2022', '01-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Completed visits for current interval must be an integer and cannot be nil')
    end

    it "should respond with friendly error message if extra sessionss allowable is not an integer or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 'one', interval_for_extra_sessions_allowable: 'monthly' }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-22-2022'
      non_business_days = ['01-01-2022', '01-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Extra sessions allowable must be an integer and cannot be nil')
    end

    it "should respond with friendly error message if interval for extra sessions allowable is not a string or not passed in" do
      school_plan = {school_plan_services: [{school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: nil }, {school_plan_type: 'IEP', start_date: '01-01-2022', end_date: '01-01-2023', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sessions_allowable: 'monthly' }]}
      date = '01-22-2022'
      non_business_days = ['01-01-2022', '01-22-2022']
      expect { Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate }.to raise_error('Interval for extra sessions allowable must be a string and cannot be nil')
    end

  end
end