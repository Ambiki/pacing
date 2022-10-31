require 'spec_helper'
require 'date'

RSpec.describe Pacing::Pacer do
  describe "Cue based specs" do
    it "should correctly parse the pacing for patient 4566" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4575" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-06-2021", :end_date=>"12-06-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-06-2021", :end_date=>"12-06-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4584" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-15-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4586" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 4607" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"12-02-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-09-2002", :end_date=>"12-02-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4614" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4627" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"03-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4628" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4629" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-11-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4653" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4655" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"08-15-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"08-15-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4674" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4679" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"03-21-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4681" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"04-04-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"04-04-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4688" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4697" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-06-2021", :end_date=>"11-06-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4700" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4725" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4736" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-04-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4738" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-04-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4764" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4765" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"05-24-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"02-28-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4767" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-03-2022", :end_date=>"05-03-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-03-2022", :end_date=>"05-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4772" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-18-2022", :end_date=>"08-18-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4778" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4783" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-14-2022", :end_date=>"07-07-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4787" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4813" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4829" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-01-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4830" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-01-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 4856" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4870" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-18-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4874" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"11-30-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4878" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4879" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-07-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4880" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-09-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>5, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4882" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4901" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-27-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4905" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-28-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4919" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4933" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-13-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 4934" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4939" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>73, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>73, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>43, :used_visits=>65, :pace=>-38, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>103, :reset_date=>"11-03-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>29, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>30, :reset_date=>"11-03-2022"}])
    end

    it "should correctly parse the pacing for patient 4941" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-22-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4944" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-11-2021", :end_date=>"11-11-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>66, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"11-11-2021", :end_date=>"11-11-2022", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>66, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>60, :used_visits=>48, :pace=>-52, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>100, :reset_date=>"11-11-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>28, :pace=>-2, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>30, :reset_date=>"11-11-2022"}])
    end

    it "should correctly parse the pacing for patient 4953" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-11-2021", :end_date=>"11-11-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4954" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2023", :end_date=>"06-30-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2023", :end_date=>"06-30-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4957" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4964" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4971" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4973" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"11-29-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4974" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"11-29-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4982" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-09-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 4991" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-15-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5009" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-18-2022", :end_date=>"08-18-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5015" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5017" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5032" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5034" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5045" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5051" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5059" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-20-2021", :end_date=>"10-20-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-20-2021", :end_date=>"10-20-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5060" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5062" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5071" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5088" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5090" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"04-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5093" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-04-2021", :end_date=>"11-04-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5097" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>83, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>83, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>91, :used_visits=>17, :pace=>-28, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>45, :reset_date=>"05-19-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>23, :used_visits=>9, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>13, :reset_date=>"05-19-2023"}])
    end

    it "should correctly parse the pacing for patient 5102" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5114" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5115" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5116" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-23-2021", :end_date=>"11-22-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5126" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"09-03-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"09-03-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5127" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5131" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"08-16-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5136" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"07-27-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"07-27-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"07-28-2022", :end_date=>"03-28-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"07-28-2022", :end_date=>"03-28-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5143" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5146" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>81, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>81, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>35, :used_visits=>73, :pace=>-31, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>104, :reset_date=>"10-29-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>31, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>31, :reset_date=>"10-29-2022"}])
    end

    it "should correctly parse the pacing for patient 5150" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"11-22-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5154" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-27-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5158" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5163" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5171" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5173" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5181" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5184" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5192" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-30-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5198" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5205" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5210" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-14-2022", :end_date=>"05-20-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"02-14-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5211" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"11-17-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"11-17-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5213" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-27-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5215" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-20-2022", :end_date=>"12-01-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-20-2022", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5222" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5223" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5228" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5231" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5242" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-07-2022", :end_date=>"10-07-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 5249" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-12-2022", :end_date=>"10-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5253" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"05-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5261" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-14-2022", :end_date=>"07-07-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-14-2022", :end_date=>"07-07-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5263" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5264" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5275" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-24-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 5279" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-18-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-18-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5286" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"10-06-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"10-06-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>3, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5291" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 5310" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-15-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 5315" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 5322" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5324" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-20-2022", :end_date=>"01-20-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5327" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5331" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-02-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5332" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>47, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>36, :used_visits=>19, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>24, :reset_date=>"05-10-2023"}])
    end

    it "should correctly parse the pacing for patient 5333" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5342" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5348" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 5361" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-29-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 5363" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"02-16-2023", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>93, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"02-16-2023", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>93, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"02-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>93, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>60, :used_visits=>48, :pace=>-20, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>68, :reset_date=>"02-16-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>12, :used_visits=>20, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>20, :reset_date=>"02-16-2023"}])
    end

    it "should correctly parse the pacing for patient 5364" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-04-2022", :end_date=>"10-04-2023", :type_of_service=>"Speech Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>62, :used_visits=>3, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"10-04-2023"}])
    end

    it "should correctly parse the pacing for patient 5365" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-18-2023", :type_of_service=>"Speech Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>70, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-18-2023", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>70, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-06-2022", :end_date=>"06-24-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-06-2022", :end_date=>"06-24-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>45, :used_visits=>55, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>66, :reset_date=>"02-18-2023"}])
    end

    it "should correctly parse the pacing for patient 5368" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>44, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>44, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>47, :used_visits=>33, :pace=>-21, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>54, :reset_date=>"02-10-2023"}])
    end

    it "should correctly parse the pacing for patient 5369" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>49, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>49, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>27, :used_visits=>38, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>44, :reset_date=>"02-10-2023"}])
    end

    it "should correctly parse the pacing for patient 5374" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-03-2022", :end_date=>"05-03-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>57, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>41, :used_visits=>29, :pace=>-3, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>32, :reset_date=>"05-03-2023"}])
    end

    it "should correctly parse the pacing for patient 5380" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5394" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5396" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>47, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>47, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>17, :used_visits=>43, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>42, :reset_date=>"02-01-2023"}])
    end

    it "should correctly parse the pacing for patient 5397" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>57, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>57, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>55, :used_visits=>63, :pace=>-44, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>107, :reset_date=>"11-19-2022"}])
    end

    it "should correctly parse the pacing for patient 5399" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Language Therapy", :frequency=>65, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>23, :used_visits=>42, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>49, :reset_date=>"01-12-2023"}])
    end

    it "should correctly parse the pacing for patient 5400" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>82, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>82, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>90, :used_visits=>18, :pace=>-28, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>46, :reset_date=>"05-16-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>23, :used_visits=>9, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>14, :reset_date=>"05-16-2023"}])
    end

    it "should correctly parse the pacing for patient 5406" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5407" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-28-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-28-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5409" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5413" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5415" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5419" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5422" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-10-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 5426" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5430" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5435" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5440" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-16-2021", :end_date=>"12-16-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 5443" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>16, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>6, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5445" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5462" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5464" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>57, :used_visits=>13, :pace=>6, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"09-08-2023"}])
    end

    it "should correctly parse the pacing for patient 5466" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-01-2021", :end_date=>"10-31-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5470" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5471" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"03-03-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"05-23-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5475" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"08-15-2023", :type_of_service=>"Speech Therapy", :frequency=>65, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>48, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>59, :used_visits=>16, :pace=>3, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>13, :reset_date=>"08-15-2023"}])
    end

    it "should correctly parse the pacing for patient 5480" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5484" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5485" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5487" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-22-2021", :end_date=>"11-21-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5494" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>46, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>45, :used_visits=>25, :pace=>-9, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>34, :reset_date=>"04-25-2023"}])
    end

    it "should correctly parse the pacing for patient 5496" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Speech Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>63, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>54, :used_visits=>36, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>43, :reset_date=>"04-25-2023"}])
    end

    it "should correctly parse the pacing for patient 5497" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>18, :used_visits=>12, :pace=>-2, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>14, :reset_date=>"04-26-2023"}])
    end

    it "should correctly parse the pacing for patient 5500" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5507" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5510" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"01-01-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-01-2023", :end_date=>"09-29-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5516" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5517" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5518" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5520" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5521" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5525" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5533" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-21-2022", :end_date=>"01-21-2023", :type_of_service=>"Speech Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>23, :used_visits=>42, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>48, :reset_date=>"01-21-2023"}])
    end

    it "should correctly parse the pacing for patient 5534" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-27-2021", :end_date=>"10-27-2022", :type_of_service=>"Speech Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>40, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>52, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>53, :reset_date=>"10-27-2022"}])
    end

    it "should correctly parse the pacing for patient 5535" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5546" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5548" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5558" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5561" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5570" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5573" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>48, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>54, :used_visits=>6, :pace=>3, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"09-28-2023"}])
    end

    it "should correctly parse the pacing for patient 5574" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>64, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>64, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>57, :used_visits=>13, :pace=>5, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"09-07-2023"}])
    end

    it "should correctly parse the pacing for patient 5583" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5601" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5602" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>46, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>100, :used_visits=>8, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"09-19-2023"}])
    end

    it "should correctly parse the pacing for patient 5605" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>40, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>52, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>53, :reset_date=>"10-28-2022"}])
    end

    it "should correctly parse the pacing for patient 5611" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-18-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 5622" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5625" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-04-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>84, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>45, :used_visits=>73, :pace=>-9, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>82, :reset_date=>"02-04-2023"}])
    end

    it "should correctly parse the pacing for patient 5632" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-17-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5634" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5635" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5638" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5640" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-09-2021", :end_date=>"11-09-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-09-2021", :end_date=>"11-09-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5644" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5650" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5661" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5665" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2023", :end_date=>"06-30-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2023", :end_date=>"06-30-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5666" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2023", :end_date=>"06-30-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5675" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5680" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5689" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-08-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5692" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-16-2021", :end_date=>"12-16-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-16-2021", :end_date=>"12-16-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5693" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>100, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>103, :used_visits=>15, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>15, :reset_date=>"09-01-2023"}])
    end

    it "should correctly parse the pacing for patient 5694" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>51, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>51, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>48, :used_visits=>12, :pace=>4, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"08-29-2023"}])
    end

    it "should correctly parse the pacing for patient 5701" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-19-2022", :end_date=>"12-10-2022", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>63, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"04-19-2022", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>63, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>74, :used_visits=>34, :pace=>-49, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>83, :reset_date=>"12-10-2022"}])
    end

    it "should correctly parse the pacing for patient 5708" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-21-2022", :end_date=>"02-21-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>56, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>28, :used_visits=>42, :pace=>-4, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>46, :reset_date=>"02-21-2023"}])
    end

    it "should correctly parse the pacing for patient 5713" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-18-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5716" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-20-2022", :end_date=>"01-20-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5717" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5719" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5721" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-25-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-25-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5726" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5730" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5731" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5741" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5751" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5752" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-02-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5762" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"11-05-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"11-05-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5768" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-13-2022", :end_date=>"01-13-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5769" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5772" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-03-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5774" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-11-2023", :type_of_service=>"Speech Therapy", :frequency=>62, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>17, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>45, :used_visits=>17, :pace=>-30, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>47, :reset_date=>"01-11-2023"}])
    end

    it "should correctly parse the pacing for patient 5799" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5812" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>67, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>83, :used_visits=>35, :pace=>-26, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>61, :reset_date=>"04-12-2023"}])
    end

    it "should correctly parse the pacing for patient 5814" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-21-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5822" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5824" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5825" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5828" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5829" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"03-07-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"03-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5832" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-26-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-26-2022", :type_of_service=>"Occupation Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5833" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5835" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Speech and Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 5850" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Language Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>35, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>51, :used_visits=>4, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"09-16-2023"}])
    end

    it "should correctly parse the pacing for patient 5852" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5859" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5862" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2023", :end_date=>"06-30-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2023", :end_date=>"06-30-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5863" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-18-2022", :end_date=>"10-18-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5865" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5868" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"03-25-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5878" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-19-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>92, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>92, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>45, :used_visits=>63, :pace=>-17, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>80, :reset_date=>"01-19-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>9, :used_visits=>23, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>24, :reset_date=>"01-19-2023"}])
    end

    it "should correctly parse the pacing for patient 5887" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5892" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-21-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5896" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-03-2022", :end_date=>"02-03-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-03-2022", :end_date=>"02-03-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5898" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5901" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5932" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-17-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5937" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-22-2021", :end_date=>"10-21-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-22-2021", :end_date=>"10-21-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5939" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5940" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5942" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"03-20-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5944" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-26-2022", :end_date=>"09-26-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 5948" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-29-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-29-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>21, :used_visits=>4, :pace=>-9, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>13, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5954" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5957" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5959" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5966" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5990" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 5991" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6003" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"03-30-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"07-29-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 6028" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6038" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6039" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-02-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6042" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-02-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6060" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6061" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6064" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"01-25-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"01-25-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>9, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6065" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>12, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>10, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>6, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"01-19-2023"}])
    end

    it "should correctly parse the pacing for patient 6066" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6067" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"03-07-2023"}])
    end

    it "should correctly parse the pacing for patient 6068" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6069" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-01-2021", :end_date=>"11-01-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-01-2021", :end_date=>"11-01-2022", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6074" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-04-2022", :end_date=>"10-04-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6088" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6108" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-07-2022", :end_date=>"04-08-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-07-2022", :end_date=>"04-08-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6137" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6150" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6163" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-01-2023", :type_of_service=>"Speech Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>57, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>77, :used_visits=>14, :pace=>3, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>11, :reset_date=>"09-01-2023"}])
    end

    it "should correctly parse the pacing for patient 6171" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-13-2022", :end_date=>"01-13-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6182" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-18-2023", :type_of_service=>"Speech Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>67, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>72, :used_visits=>19, :pace=>4, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>15, :reset_date=>"08-18-2023"}])
    end

    it "should correctly parse the pacing for patient 6184" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-15-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6185" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"05-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"05-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6186" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6191" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>48, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>43, :used_visits=>27, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>33, :reset_date=>"04-26-2023"}])
    end

    it "should correctly parse the pacing for patient 6201" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>35, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>51, :used_visits=>30, :pace=>-26, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>56, :reset_date=>"02-08-2023"}])
    end

    it "should correctly parse the pacing for patient 6216" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>40, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>38, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Speech Therapy", :frequency=>41, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>38, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>69, :used_visits=>12, :pace=>-22, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>34, :reset_date=>"05-17-2023"}])
    end

    it "should correctly parse the pacing for patient 6225" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>68, :used_visits=>23, :pace=>-27, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>50, :reset_date=>"04-01-2023"}])
    end

    it "should correctly parse the pacing for patient 6230" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>18, :used_visits=>52, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>65, :reset_date=>"11-10-2022"}])
    end

    it "should correctly parse the pacing for patient 6236" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-15-2022", :type_of_service=>"Speech Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>0, :used_visits=>56, :pace=>9, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>47, :reset_date=>"11-15-2022"}])
    end

    it "should correctly parse the pacing for patient 6264" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Speech Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>44, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>42, :used_visits=>49, :pace=>-36, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>85, :reset_date=>"11-08-2022"}])
    end

    it "should correctly parse the pacing for patient 6266" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>56, :used_visits=>24, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>37, :reset_date=>"04-29-2023"}])
    end

    it "should correctly parse the pacing for patient 6275" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-18-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6276" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6282" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6285" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>10, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>30, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>8, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"02-28-2023"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6287" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6289" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-01-2021", :end_date=>"11-01-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6291" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"12-10-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"12-10-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6293" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"03-29-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"03-29-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"03-29-2023", :type_of_service=>"Language Therapy", :frequency=>9, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6294" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-01-2021", :end_date=>"11-01-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6296" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"05-20-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6298" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6307" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"04-06-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"04-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6308" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6311" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-13-2022", :end_date=>"12-13-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6318" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6320" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 6321" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6323" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6344" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-05-2022", :end_date=>"04-27-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"08-04-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6348" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-10-2022", :end_date=>"01-10-2023", :type_of_service=>"Speech Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>42, :pace=>4, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>38, :reset_date=>"01-10-2023"}])
    end

    it "should correctly parse the pacing for patient 6350" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6357" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6359" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6360" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6361" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6362" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6365" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6367" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6369" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Speech Therapy", :frequency=>40, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>76, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>41, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>76, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>49, :used_visits=>42, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>48, :reset_date=>"04-07-2023"}])
    end

    it "should correctly parse the pacing for patient 6371" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>73, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>82, :used_visits=>9, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"09-09-2023"}])
    end

    it "should correctly parse the pacing for patient 6375" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>70, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>77, :used_visits=>14, :pace=>4, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>10, :reset_date=>"09-06-2023"}])
    end

    it "should correctly parse the pacing for patient 6376" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-18-2022", :end_date=>"08-18-2023", :type_of_service=>"Speech Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>65, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>63, :used_visits=>18, :pace=>5, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>13, :reset_date=>"08-18-2023"}])
    end

    it "should correctly parse the pacing for patient 6381" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-03-2023", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>75, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>37, :used_visits=>54, :pace=>-2, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>56, :reset_date=>"03-03-2023"}])
    end

    it "should correctly parse the pacing for patient 6383" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"03-07-2023", :type_of_service=>"Language Therapy", :frequency=>41, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>71, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"03-07-2023", :type_of_service=>"Speech Therapy", :frequency=>40, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>71, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>39, :used_visits=>52, :pace=>-4, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>56, :reset_date=>"03-07-2023"}])
    end

    it "should correctly parse the pacing for patient 6389" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-03-2023", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>73, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>37, :used_visits=>54, :pace=>-2, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>56, :reset_date=>"03-03-2023"}])
    end

    it "should correctly parse the pacing for patient 6404" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-11-2022", :end_date=>"08-11-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>47, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>56, :used_visits=>14, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>13, :reset_date=>"08-11-2023"}])
    end

    it "should correctly parse the pacing for patient 6409" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>62, :used_visits=>18, :pace=>-15, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>33, :reset_date=>"05-19-2023"}])
    end

    it "should correctly parse the pacing for patient 6416" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-16-2021", :end_date=>"12-16-2022", :type_of_service=>"Language Therapy", :frequency=>35, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>29, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>29, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>29, :reset_date=>"12-16-2022"}])
    end

    it "should correctly parse the pacing for patient 6417" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-18-2021", :end_date=>"10-18-2022", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>46, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>34, :used_visits=>57, :pace=>-34, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>91, :reset_date=>"10-18-2022"}])
    end

    it "should correctly parse the pacing for patient 6422" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>53, :used_visits=>27, :pace=>-15, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>42, :reset_date=>"04-08-2023"}])
    end

    it "should correctly parse the pacing for patient 6429" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>52, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>46, :used_visits=>24, :pace=>-8, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>32, :reset_date=>"05-05-2023"}])
    end

    it "should correctly parse the pacing for patient 6432" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-05-2021", :end_date=>"11-04-2022", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>46, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>14, :used_visits=>56, :pace=>-10, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>66, :reset_date=>"11-04-2022"}])
    end

    it "should correctly parse the pacing for patient 6459" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-24-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6461" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-26-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6477" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 6478" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-11-2022", :end_date=>"10-11-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>3, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6487" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"12-03-2022", :type_of_service=>"Language Therapy", :frequency=>10, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-03-2022", :type_of_service=>"Occupation Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6490" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6492" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6496" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-30-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6500" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"11-30-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 6503" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6547" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-12-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-12-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6548" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Language Therapy", :frequency=>10, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6549" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-17-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6550" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6552" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6556" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-15-2023", :type_of_service=>"Speech Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>68, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>36, :used_visits=>55, :pace=>-6, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>61, :reset_date=>"02-15-2023"}])
    end

    it "should correctly parse the pacing for patient 6563" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-25-2021", :end_date=>"10-24-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-25-2021", :end_date=>"10-24-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-24-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-24-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6567" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6575" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"04-04-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>37, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>50, :used_visits=>20, :pace=>-18, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>38, :reset_date=>"04-04-2023"}])
    end

    it "should correctly parse the pacing for patient 6580" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6587" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Language Therapy", :frequency=>35, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>52, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Speech Therapy", :frequency=>35, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>52, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>42, :used_visits=>38, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>49, :reset_date=>"03-09-2023"}])
    end

    it "should correctly parse the pacing for patient 6601" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Language Therapy", :frequency=>10, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6602" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6603" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6638" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Language Therapy", :frequency=>41, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>69, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Speech Therapy", :frequency=>40, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>69, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>80, :used_visits=>11, :pace=>2, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"09-09-2023"}])
    end

    it "should correctly parse the pacing for patient 6651" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"03-21-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6659" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6666" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"01-13-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6667" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"01-13-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6668" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"11-30-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6673" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6681" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6682" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"11-09-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"05-24-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6690" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6700" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6703" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"08-31-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 6717" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"07-31-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"07-31-2022", :end_date=>"04-26-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6728" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6736" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-26-2022", :end_date=>"11-03-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-26-2022", :end_date=>"11-03-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6737" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"05-23-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6741" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>64, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>102, :used_visits=>16, :pace=>-37, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>53, :reset_date=>"05-06-2023"}])
    end

    it "should correctly parse the pacing for patient 6742" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6749" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6750" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>58, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>58, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-28-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>86, :used_visits=>32, :pace=>-30, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>62, :reset_date=>"04-07-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>33, :used_visits=>9, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>22, :reset_date=>"04-07-2023"}])
    end

    it "should correctly parse the pacing for patient 6753" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6754" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-29-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-29-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6756" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-26-2022", :end_date=>"09-26-2023", :type_of_service=>"Language Therapy", :frequency=>9, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>4, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6762" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-03-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-03-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 6768" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-30-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6769" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"01-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"01-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6772" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6781" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-06-2021", :end_date=>"12-06-2022", :type_of_service=>"Language Therapy", :frequency=>10, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6782" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6800" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-20-2022", :end_date=>"01-20-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6801" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-20-2022", :end_date=>"01-20-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6802" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-20-2022", :end_date=>"01-20-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-04-2022", :end_date=>"01-20-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6808" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6819" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-05-2021", :end_date=>"11-04-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-05-2021", :end_date=>"11-04-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6822" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>49, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>42, :used_visits=>28, :pace=>-9, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>37, :reset_date=>"04-05-2023"}])
    end

    it "should correctly parse the pacing for patient 6829" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"02-16-2023", :type_of_service=>"Language Therapy", :frequency=>9, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6832" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>74, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>74, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>60, :used_visits=>58, :pace=>-56, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>114, :reset_date=>"10-28-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>8, :used_visits=>34, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>41, :reset_date=>"10-28-2022"}])
    end

    it "should correctly parse the pacing for patient 6836" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6837" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6839" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>37, :used_visits=>44, :pace=>-18, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>62, :reset_date=>"01-12-2023"}])
    end

    it "should correctly parse the pacing for patient 6851" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-04-2021", :end_date=>"11-04-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-04-2021", :end_date=>"11-04-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6855" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6858" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6859" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6867" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6868" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-21-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6872" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6893" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"03-16-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"03-16-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6895" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"04-05-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"04-05-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>4, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6907" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-02-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-02-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6910" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"02-02-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>56, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>91, :used_visits=>17, :pace=>-20, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>37, :reset_date=>"02-02-2023"}])
    end

    it "should correctly parse the pacing for patient 6912" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6919" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"01-31-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6926" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-22-2021", :end_date=>"11-22-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6928" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6934" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Speech and Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6936" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6939" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6940" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-04-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6950" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6958" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"03-22-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6963" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-20-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6964" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>71, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>39, :used_visits=>27, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>31, :reset_date=>"04-28-2023"}])
    end

    it "should correctly parse the pacing for patient 6979" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6989" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 6996" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"08-15-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>42, :used_visits=>3, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"08-15-2023"}])
    end

    it "should correctly parse the pacing for patient 6997" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7001" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7010" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-13-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-13-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-31-2022", :end_date=>"06-23-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-31-2022", :end_date=>"06-23-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7015" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>75, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>49, :used_visits=>42, :pace=>-6, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>48, :reset_date=>"04-07-2023"}])
    end

    it "should correctly parse the pacing for patient 7017" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-04-2022", :end_date=>"10-04-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>78, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>117, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"10-04-2023"}])
    end

    it "should correctly parse the pacing for patient 7019" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-18-2021", :end_date=>"10-18-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7036" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7037" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7038" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7040" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-15-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7043" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>79, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>79, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>79, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>82, :used_visits=>26, :pace=>-26, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>52, :reset_date=>"04-26-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>22, :used_visits=>10, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>15, :reset_date=>"04-26-2023"}])
    end

    it "should correctly parse the pacing for patient 7044" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>75, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>75, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-28-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-28-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>72, :used_visits=>46, :pace=>-34, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>80, :reset_date=>"02-10-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>25, :used_visits=>17, :pace=>-12, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>29, :reset_date=>"02-10-2023"}])
    end

    it "should correctly parse the pacing for patient 7055" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-30-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-30-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 7058" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>75, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>101, :used_visits=>7, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"09-15-2023"}])
    end

    it "should correctly parse the pacing for patient 7060" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>83, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>83, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>83, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>32, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-05-2023"}, {:discipline=>"Speech Therapy", :remaining_visits=>107, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"10-05-2023"}])
    end

    it "should correctly parse the pacing for patient 7067" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-04-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-04-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7072" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"02-23-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7073" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7077" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"01-27-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7086" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7094" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7100" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-20-2023", :type_of_service=>"Speech Therapy", :frequency=>9, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7103" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7114" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"03-07-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7121" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7123" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7127" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"03-03-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7130" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7138" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7146" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7147" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7157" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-15-2022", :end_date=>"03-15-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7158" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"03-20-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"03-20-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7159" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>70, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>84, :used_visits=>7, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"09-16-2023"}])
    end

    it "should correctly parse the pacing for patient 7160" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-18-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7161" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7162" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-05-2021", :end_date=>"11-05-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7164" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-04-2022", :end_date=>"03-14-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7168" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7177" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>34, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7182" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-06-2021", :end_date=>"12-06-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7198" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7209" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>52, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>79, :used_visits=>29, :pace=>-28, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>57, :reset_date=>"04-07-2023"}])
    end

    it "should correctly parse the pacing for patient 7210" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-08-2022", :end_date=>"04-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7211" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"02-04-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7213" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>67, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>44, :used_visits=>74, :pace=>-30, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>104, :reset_date=>"11-30-2022"}])
    end

    it "should correctly parse the pacing for patient 7221" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-17-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-17-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-14-2022", :end_date=>"07-07-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-14-2022", :end_date=>"07-07-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7222" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-14-2022", :end_date=>"07-07-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7226" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Speech Therapy", :frequency=>16, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>5, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7229" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>53, :used_visits=>27, :pace=>-12, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>39, :reset_date=>"04-22-2023"}])
    end

    it "should correctly parse the pacing for patient 7234" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7236" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7239" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7250" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-03-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7252" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"12-13-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7263" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>72, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>109, :used_visits=>9, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>10, :reset_date=>"09-16-2023"}])
    end

    it "should correctly parse the pacing for patient 7267" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-26-2022", :end_date=>"09-26-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-26-2022", :end_date=>"09-26-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7272" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7273" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-06-2022", :end_date=>"01-06-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7290" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>111, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>111, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>69, :used_visits=>49, :pace=>-23, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>72, :reset_date=>"03-09-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>20, :used_visits=>22, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>25, :reset_date=>"03-09-2023"}])
    end

    it "should correctly parse the pacing for patient 7293" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7294" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-09-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-09-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7298" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7300" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7301" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7303" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>4, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7308" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-06-2021", :end_date=>"12-06-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7319" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-04-2021", :end_date=>"11-04-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7335" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"03-21-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7340" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"04-04-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"04-04-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7349" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 7353" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-13-2022", :end_date=>"01-13-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7371" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>23, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>20, :used_visits=>12, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>16, :reset_date=>"04-14-2023"}])
    end

    it "should correctly parse the pacing for patient 7398" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"11-09-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"11-09-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"07-29-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"07-29-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 7400" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-13-2022", :end_date=>"01-13-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 7401" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7404" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7417" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"05-20-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7418" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"12-10-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7420" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-18-2022", :end_date=>"03-18-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7421" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-26-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7422" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-18-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7426" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7428" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7429" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7431" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7437" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 7452" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>65, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>113, :used_visits=>5, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"09-22-2023"}])
    end

    it "should correctly parse the pacing for patient 7456" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-31-2022", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>26, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>15, :used_visits=>27, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>34, :reset_date=>"12-31-2022"}])
    end

    it "should correctly parse the pacing for patient 7462" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7468" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-11-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-11-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7477" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-19-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7480" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-20-2021", :end_date=>"10-20-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-20-2021", :end_date=>"10-20-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7492" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-20-2021", :end_date=>"10-20-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7495" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7506" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>3, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7513" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7522" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"03-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7524" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7526" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-14-2022", :end_date=>"05-24-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"02-03-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7533" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-04-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7538" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 7565" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 7578" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-25-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-25-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7583" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7590" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7592" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-24-2021", :end_date=>"10-20-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7602" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"12-08-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7603" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-01-2021", :end_date=>"11-01-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7606" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7608" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>90, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>90, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>82, :used_visits=>26, :pace=>-26, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>52, :reset_date=>"04-25-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>22, :used_visits=>10, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>15, :reset_date=>"04-25-2023"}])
    end

    it "should correctly parse the pacing for patient 7609" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>80, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>31, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"08-03-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>31, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>92, :used_visits=>16, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>29, :reset_date=>"05-10-2023"}])
    end

    it "should correctly parse the pacing for patient 7613" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>15, :used_visits=>1, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7616" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7625" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7634" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>9, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7637" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-27-2021", :end_date=>"10-26-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7673" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 7685" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7687" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-08-2023", :type_of_service=>"Language Therapy", :frequency=>41, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>36, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-08-2023", :type_of_service=>"Speech Therapy", :frequency=>40, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>36, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>20, :used_visits=>31, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>35, :reset_date=>"02-08-2023"}])
    end

    it "should correctly parse the pacing for patient 7690" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7691" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-04-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7701" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-20-2022", :end_date=>"04-20-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 7702" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7708" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7712" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"11-05-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7713" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"02-03-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-20-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7715" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"02-16-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-19-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"02-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7716" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-20-2022", :end_date=>"05-19-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-20-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7717" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7737" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7740" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"07-31-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7743" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7746" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-22-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7769" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7771" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Speech Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>32, :used_visits=>0, :pace=>-18, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>18, :reset_date=>"03-22-2023"}])
    end

    it "should correctly parse the pacing for patient 7776" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7778" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7788" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-09-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-09-2022", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7790" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7794" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7797" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-03-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7798" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7825" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-25-2021", :end_date=>"10-24-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-25-2021", :end_date=>"10-24-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7826" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7839" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-15-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7844" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"11-03-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"11-03-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7854" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7859" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-27-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-27-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7860" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"01-25-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7861" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-14-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7877" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>14, :used_visits=>3, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7883" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7888" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"08-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7894" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7896" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7901" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7914" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"10-27-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7915" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-09-2021", :end_date=>"11-09-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7916" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-06-2021", :end_date=>"12-06-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7917" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7920" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7924" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7927" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"01-25-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7933" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7947" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>5, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7966" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-18-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>38, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>56, :used_visits=>14, :pace=>-15, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>29, :reset_date=>"05-18-2023"}])
    end

    it "should correctly parse the pacing for patient 7975" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-01-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7988" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-05-2021", :end_date=>"11-05-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7989" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7991" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7993" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 7994" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8011" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"01-13-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"01-13-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8019" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"05-13-2023", :type_of_service=>"Language Therapy", :frequency=>41, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>48, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"05-13-2023", :type_of_service=>"Speech Therapy", :frequency=>40, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>48, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>72, :used_visits=>19, :pace=>-20, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>39, :reset_date=>"05-13-2023"}])
    end

    it "should correctly parse the pacing for patient 8020" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-02-2022", :end_date=>"02-16-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-02-2022", :end_date=>"02-16-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8030" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>44, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>63, :used_visits=>17, :pace=>-18, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>35, :reset_date=>"05-12-2023"}])
    end

    it "should correctly parse the pacing for patient 8031" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Language Therapy", :frequency=>35, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>48, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Speech Therapy", :frequency=>35, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>48, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>65, :used_visits=>5, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"09-19-2023"}])
    end

    it "should correctly parse the pacing for patient 8053" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"03-31-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"03-31-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8067" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>49, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>60, :used_visits=>20, :pace=>-15, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>35, :reset_date=>"05-12-2023"}])
    end

    it "should correctly parse the pacing for patient 8070" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"03-31-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8089" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8090" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8092" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-04-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>4, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8093" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8103" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8104" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>3, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8105" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"03-30-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"03-30-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8110" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"03-25-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"03-25-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8111" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8112" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-11-2021", :end_date=>"11-08-2022", :type_of_service=>"Language Therapy", :frequency=>50, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>37, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>49, :pace=>2, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>47, :reset_date=>"11-08-2022"}])
    end

    it "should correctly parse the pacing for patient 8113" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8117" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8118" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8119" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"03-21-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8120" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8126" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>5, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8133" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8134" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8145" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8146" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8150" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>39, :used_visits=>31, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>42, :reset_date=>"03-09-2023"}])
    end

    it "should correctly parse the pacing for patient 8151" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-11-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>35, :used_visits=>45, :pace=>-16, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>61, :reset_date=>"01-11-2023"}])
    end

    it "should correctly parse the pacing for patient 8156" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"02-25-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"02-25-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8164" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>97, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>97, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>97, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>86, :used_visits=>22, :pace=>-26, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>48, :reset_date=>"05-09-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>21, :used_visits=>11, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>14, :reset_date=>"05-09-2023"}])
    end

    it "should correctly parse the pacing for patient 8168" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days).calculate
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end
  end
end