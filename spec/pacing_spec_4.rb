require 'spec_helper'
require 'date'

RSpec.describe Pacing::Pacer do
  describe "Cue based specs" do
    it "should correctly parse the pacing for patient 10788" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-24-2021", :end_date=>"10-20-2022", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>32, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"10-24-2021", :end_date=>"10-20-2022", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>32, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>20, :used_visits=>40, :pace=>-19, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>59, :reset_date=>"10-20-2022"}])
    end

    it "should correctly parse the pacing for patient 10789" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-20-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-20-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10797" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10800" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-25-2021", :end_date=>"10-25-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10802" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10805" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-09-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-09-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10806" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-04-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10815" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"11-04-2022", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>48, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>37, :used_visits=>33, :pace=>-31, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>64, :reset_date=>"11-04-2022"}])
    end

    it "should correctly parse the pacing for patient 10826" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10829" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-06-2022", :end_date=>"01-25-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-06-2022", :end_date=>"01-25-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10830" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-11-2021", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>38, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"11-11-2021", :end_date=>"11-10-2022", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>38, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>14, :used_visits=>46, :pace=>-10, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>56, :reset_date=>"11-10-2022"}])
    end

    it "should correctly parse the pacing for patient 10834" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-04-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>1, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10835" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-09-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10837" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10838" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10841" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-19-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10843" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-24-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-24-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10846" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>40, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>73, :used_visits=>18, :pace=>-21, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>39, :reset_date=>"05-12-2023"}])
    end

    it "should correctly parse the pacing for patient 10850" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"11-08-2022", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>56, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"11-08-2022", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>56, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>84, :used_visits=>6, :pace=>-46, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>52, :reset_date=>"11-08-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>30, :used_visits=>0, :pace=>-17, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>17, :reset_date=>"11-08-2022"}])
    end

    it "should correctly parse the pacing for patient 10859" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-17-2021", :end_date=>"12-17-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-17-2021", :end_date=>"12-17-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10865" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10879" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"03-29-2023", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>37, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"03-29-2023", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>37, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>81, :used_visits=>37, :pace=>-28, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>65, :reset_date=>"03-29-2023"}])
    end

    it "should correctly parse the pacing for patient 10884" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>99, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>26, :used_visits=>6, :pace=>3, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"09-12-2023"}])
    end

    it "should correctly parse the pacing for patient 10890" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-27-2021", :end_date=>"10-27-2022", :type_of_service=>"Language Therapy", :frequency=>50, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>53, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>56, :pace=>-2, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>58, :reset_date=>"10-27-2022"}])
    end

    it "should correctly parse the pacing for patient 10892" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-27-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-27-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10896" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10902" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10903" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10911" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-17-2022", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>23, :used_visits=>47, :pace=>-17, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>64, :reset_date=>"11-17-2022"}])
    end

    it "should correctly parse the pacing for patient 10913" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10917" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>23, :used_visits=>47, :pace=>-17, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>64, :reset_date=>"11-18-2022"}])
    end

    it "should correctly parse the pacing for patient 10918" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"11-10-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10919" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10926" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10927" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-06-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>28, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>31, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>32, :reset_date=>"11-18-2022"}])
    end

    it "should correctly parse the pacing for patient 10928" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"03-09-2023", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"03-09-2023", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>48, :used_visits=>12, :pace=>-19, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>31, :reset_date=>"03-09-2023"}])
    end

    it "should correctly parse the pacing for patient 10929" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10932" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"11-23-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10945" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10946" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10947" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10948" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10949" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"03-03-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10957" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-18-2022", :end_date=>"08-18-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10959" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Speech Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>8, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>24, :used_visits=>8, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>21, :reset_date=>"02-16-2023"}])
    end

    it "should correctly parse the pacing for patient 10960" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-04-2022", :end_date=>"11-16-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10961" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-06-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10962" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10964" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-14-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-14-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10965" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-27-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10971" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-28-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10972" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10973" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10990" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11012" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-09-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11015" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"11-28-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"05-20-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11019" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11022" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-03-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-03-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11031" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>58, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>60, :used_visits=>58, :pace=>-50, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>108, :reset_date=>"11-16-2022"}])
    end

    it "should correctly parse the pacing for patient 11042" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"08-01-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"08-01-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-02-2023", :end_date=>"09-13-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11045" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>41, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>39, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>40, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>39, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>77, :used_visits=>14, :pace=>-27, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>41, :reset_date=>"05-04-2023"}])
    end

    it "should correctly parse the pacing for patient 11046" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Occupation Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11047" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-18-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11053" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>46, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>94, :used_visits=>14, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>15, :reset_date=>"08-26-2023"}])
    end

    it "should correctly parse the pacing for patient 11054" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11060" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11083" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>38, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>28, :used_visits=>13, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>19, :reset_date=>"05-04-2023"}])
    end

    it "should correctly parse the pacing for patient 11084" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11085" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"11-17-2022", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>58, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"11-17-2022", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>58, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>57, :used_visits=>43, :pace=>-45, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>88, :reset_date=>"11-17-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>30, :used_visits=>10, :pace=>-25, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>35, :reset_date=>"11-17-2022"}])
    end

    it "should correctly parse the pacing for patient 11086" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11087" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11091" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>45, :used_visits=>25, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>36, :reset_date=>"04-11-2023"}])
    end

    it "should correctly parse the pacing for patient 11094" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11096" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Language Therapy", :frequency=>10, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11097" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"03-24-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11100" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-08-2022", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>22, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>18, :used_visits=>22, :pace=>-12, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>34, :reset_date=>"12-08-2022"}])
    end

    it "should correctly parse the pacing for patient 11102" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"10-28-2022", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>29, :used_visits=>41, :pace=>-26, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>67, :reset_date=>"10-28-2022"}])
    end

    it "should correctly parse the pacing for patient 11107" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11110" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11124" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"03-16-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11134" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11138" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>26, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>108, :used_visits=>10, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>11, :reset_date=>"09-13-2023"}])
    end

    it "should correctly parse the pacing for patient 11143" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-29-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11146" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-18-2022", :end_date=>"01-26-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-18-2022", :end_date=>"01-26-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11149" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-28-2022", :end_date=>"12-16-2022", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>29, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>59, :used_visits=>11, :pace=>-38, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>49, :reset_date=>"12-16-2022"}])
    end

    it "should correctly parse the pacing for patient 11153" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-16-2021", :end_date=>"12-16-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11158" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11161" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"10-06-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"10-06-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11162" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11163" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-03-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11164" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-06-2022", :end_date=>"04-06-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11167" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11169" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>15, :used_visits=>1, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11170" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"11-03-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"11-03-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11173" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11174" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11175" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11177" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11179" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11180" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-23-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11182" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-18-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11183" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-04-2021", :end_date=>"11-04-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11184" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"05-20-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11187" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11188" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11189" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11193" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11194" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-02-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11195" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"01-25-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11196" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11197" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11198" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11199" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-04-2022", :end_date=>"10-04-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11200" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11201" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-10-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11202" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11203" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11204" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11206" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-16-2021", :end_date=>"12-16-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11207" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11209" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11210" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11211" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11212" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11213" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11215" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-27-2022", :end_date=>"03-22-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11216" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11217" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"10-06-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11218" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11221" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11222" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-20-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11223" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11224" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"05-23-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"05-23-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11225" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11227" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-22-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>19, :used_visits=>41, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>54, :reset_date=>"11-18-2022"}])
    end

    it "should correctly parse the pacing for patient 11241" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-14-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11248" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11249" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-05-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11250" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-14-2022", :end_date=>"03-14-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11252" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"02-18-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11257" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"03-01-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11258" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11261" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-03-2022", :end_date=>"02-03-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11262" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11264" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-27-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-27-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>6, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11266" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-10-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11269" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11271" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"12-09-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11272" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>51, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>69, :used_visits=>49, :pace=>-55, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>104, :reset_date=>"11-18-2022"}])
    end

    it "should correctly parse the pacing for patient 11277" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11278" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-28-2022", :end_date=>"01-27-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11285" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"12-15-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"12-15-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11287" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-20-2022", :end_date=>"11-22-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>63, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>55, :used_visits=>63, :pace=>-41, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>104, :reset_date=>"11-22-2022"}])
    end

    it "should correctly parse the pacing for patient 11289" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11290" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"11-17-2022", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>34, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>87, :used_visits=>21, :pace=>-70, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>91, :reset_date=>"11-17-2022"}])
    end

    it "should correctly parse the pacing for patient 11291" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>22, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>22, :pace=>-4, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>26, :reset_date=>"12-07-2022"}])
    end

    it "should correctly parse the pacing for patient 11293" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"03-01-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11303" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-05-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([])
    end

    it "should correctly parse the pacing for patient 11307" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11309" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"11-10-2022", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>40, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>93, :used_visits=>25, :pace=>-77, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>102, :reset_date=>"11-10-2022"}])
    end

    it "should correctly parse the pacing for patient 11310" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-16-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11314" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>40, :used_visits=>20, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>31, :reset_date=>"04-08-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>24, :used_visits=>6, :pace=>-10, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>16, :reset_date=>"04-08-2023"}])
    end

    it "should correctly parse the pacing for patient 11315" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-06-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>29, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>32, :used_visits=>28, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>42, :reset_date=>"02-06-2023"}])
    end

    it "should correctly parse the pacing for patient 11316" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-09-2023", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>57, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>34, :used_visits=>57, :pace=>-5, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>62, :reset_date=>"02-09-2023"}])
    end

    it "should correctly parse the pacing for patient 11325" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"03-31-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>1, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11326" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11328" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-03-2022", :end_date=>"05-03-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11329" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11335" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11336" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11338" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>56, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>54, :used_visits=>54, :pace=>-15, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>69, :reset_date=>"02-24-2023"}])
    end

    it "should correctly parse the pacing for patient 11340" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11341" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-12-2022", :end_date=>"10-20-2022", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>60, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-12-2022", :end_date=>"10-20-2022", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>60, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>60, :used_visits=>58, :pace=>-58, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>116, :reset_date=>"10-20-2022"}])
    end

    it "should correctly parse the pacing for patient 11342" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"03-25-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>51, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>61, :used_visits=>47, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>61, :reset_date=>"03-25-2023"}])
    end

    it "should correctly parse the pacing for patient 11344" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11346" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11349" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>19, :used_visits=>41, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>52, :reset_date=>"12-07-2022"}])
    end

    it "should correctly parse the pacing for patient 11350" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-13-2022", :end_date=>"01-13-2023", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>28, :used_visits=>42, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>53, :reset_date=>"01-13-2023"}])
    end

    it "should correctly parse the pacing for patient 11361" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"04-21-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11365" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11371" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11379" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-23-2022", :end_date=>"04-23-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-23-2022", :end_date=>"04-23-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11387" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-17-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11396" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"12-10-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11397" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11398" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-09-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-09-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11399" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-25-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11400" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-14-2022", :end_date=>"03-13-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11402" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11406" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11410" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-28-2022", :end_date=>"01-28-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11411" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-13-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11417" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11420" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11423" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"12-15-2022", :type_of_service=>"Speech Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>24, :used_visits=>31, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>42, :reset_date=>"12-15-2022"}])
    end

    it "should correctly parse the pacing for patient 11428" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-09-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11439" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-17-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11448" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-17-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>44, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>88, :used_visits=>20, :pace=>2, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>18, :reset_date=>"08-17-2023"}])
    end

    it "should correctly parse the pacing for patient 11449" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"02-04-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"02-04-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>17, :used_visits=>4, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>11, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11458" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-28-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11459" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11461" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"03-31-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"03-31-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11465" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11466" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-17-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11473" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-10-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11477" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-25-2022", :end_date=>"02-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11480" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11492" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11509" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-17-2021", :end_date=>"12-17-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-17-2021", :end_date=>"12-17-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11515" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-16-2021", :end_date=>"12-16-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11516" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11517" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11520" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11523" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11524" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-04-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11527" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11529" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11548" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-19-2022", :end_date=>"11-22-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>32, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>86, :used_visits=>32, :pace=>-66, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>98, :reset_date=>"11-22-2022"}])
    end

    it "should correctly parse the pacing for patient 11550" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-21-2022", :end_date=>"04-21-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-21-2022", :end_date=>"04-21-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>3, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11555" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"08-01-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-14-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11560" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11562" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11564" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11571" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-15-2023", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>17, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>17, :pace=>-3, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>20, :reset_date=>"02-15-2023"}])
    end

    it "should correctly parse the pacing for patient 11578" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"05-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11589" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11590" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11591" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Speech Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>55, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>75, :used_visits=>6, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"09-19-2023"}])
    end

    it "should correctly parse the pacing for patient 11592" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>36, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>36, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>19, :used_visits=>36, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>50, :reset_date=>"11-18-2022"}])
    end

    it "should correctly parse the pacing for patient 11593" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-09-2022", :end_date=>"11-30-2022", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>51, :used_visits=>19, :pace=>-24, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>43, :reset_date=>"11-30-2022"}])
    end

    it "should correctly parse the pacing for patient 11594" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-18-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11595" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11600" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-17-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11601" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-10-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11602" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"12-09-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11603" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11605" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11608" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"02-18-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11609" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11610" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>3, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11611" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11612" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11613" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11617" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11623" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-24-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11626" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"03-31-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11629" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-04-2022", :end_date=>"01-04-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11630" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11640" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"02-01-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11643" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-28-2022", :end_date=>"01-28-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11646" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11651" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11653" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"02-04-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11655" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11656" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-09-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([])
    end

    it "should correctly parse the pacing for patient 11658" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-18-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-01-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11659" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"05-20-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11660" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"05-20-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"05-20-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11661" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"05-20-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11663" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-28-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11664" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>34, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>37, :used_visits=>23, :pace=>-8, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>31, :reset_date=>"04-07-2023"}])
    end

    it "should correctly parse the pacing for patient 11665" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11666" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11667" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11674" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-26-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>30, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>30, :used_visits=>30, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>43, :reset_date=>"01-26-2023"}])
    end

    it "should correctly parse the pacing for patient 11675" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"04-26-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11678" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-11-2022", :end_date=>"02-28-2023", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"08-11-2022", :end_date=>"02-28-2023", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>92, :used_visits=>26, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>39, :reset_date=>"02-28-2023"}])
    end

    it "should correctly parse the pacing for patient 11679" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-18-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11690" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"02-04-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11692" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-02-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-02-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11694" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11699" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11704" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-03-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>26, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>19, :used_visits=>26, :pace=>-2, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>28, :reset_date=>"03-03-2023"}])
    end

    it "should correctly parse the pacing for patient 11705" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"03-07-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>28, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>28, :pace=>6, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>22, :reset_date=>"03-07-2023"}])
    end

    it "should correctly parse the pacing for patient 11706" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-03-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-03-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11715" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11718" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"03-07-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>24, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>24, :pace=>2, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>22, :reset_date=>"03-07-2023"}])
    end

    it "should correctly parse the pacing for patient 11732" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"03-25-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"03-25-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11734" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-12-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11736" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-05-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11737" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"03-11-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11738" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11743" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-02-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11748" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11749" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"02-23-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>36, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>87, :used_visits=>31, :pace=>-40, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>71, :reset_date=>"02-23-2023"}])
    end

    it "should correctly parse the pacing for patient 11750" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11751" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11755" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11759" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11760" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11765" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11766" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11768" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11770" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11771" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-07-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-07-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11772" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Language Therapy", :frequency=>10, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11773" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Language Therapy", :frequency=>10, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11774" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-17-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11775" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"01-27-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11776" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>1, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11778" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11779" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11781" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-14-2022", :end_date=>"02-14-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11784" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-10-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11788" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-16-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-16-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11789" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-03-2022", :end_date=>"05-03-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11792" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11793" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-14-2022", :end_date=>"03-14-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11804" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11809" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11810" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>14, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>21, :used_visits=>14, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>21, :reset_date=>"03-10-2023"}])
    end

    it "should correctly parse the pacing for patient 11811" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11812" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11816" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-17-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11817" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"03-21-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11818" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11845" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"03-16-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11846" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11847" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-07-2022", :end_date=>"10-07-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11848" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Speech Therapy", :frequency=>16, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>14, :used_visits=>3, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11852" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"05-31-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"03-23-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11854" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11855" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11858" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"04-11-2023", :type_of_service=>"Speech Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>20, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"04-11-2023", :type_of_service=>"Language Therapy", :frequency=>54, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>20, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>98, :used_visits=>20, :pace=>-35, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>55, :reset_date=>"04-11-2023"}])
    end

    it "should correctly parse the pacing for patient 11860" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"07-31-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-13-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11861" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11863" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11864" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"01-25-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>21, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>49, :used_visits=>21, :pace=>-30, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>51, :reset_date=>"01-25-2023"}])
    end

    it "should correctly parse the pacing for patient 11865" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-17-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-17-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11866" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-18-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11867" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"03-25-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>19, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>51, :used_visits=>19, :pace=>-20, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>39, :reset_date=>"03-25-2023"}])
    end

    it "should correctly parse the pacing for patient 11870" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11872" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11874" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"08-15-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11877" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Language Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>26, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>26, :pace=>3, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>23, :reset_date=>"01-26-2023"}])
    end

    it "should correctly parse the pacing for patient 11879" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"08-15-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11903" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11905" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"02-28-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11907" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11909" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11911" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-18-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11913" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-14-2022", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-14-2022", :end_date=>"11-29-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11937" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>9, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>9, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>51, :used_visits=>9, :pace=>-29, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>38, :reset_date=>"03-01-2023"}])
    end

    it "should correctly parse the pacing for patient 11946" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11955" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Speech Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>16, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>26, :used_visits=>16, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>22, :reset_date=>"04-05-2023"}])
    end

    it "should correctly parse the pacing for patient 11961" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11962" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11965" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-22-2021", :end_date=>"11-22-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11966" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"05-23-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11972" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-23-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-23-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>4, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11974" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-11-2022", :end_date=>"08-15-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11982" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11983" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-02-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 11984" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"05-18-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"05-18-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 11992" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"10-19-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"10-19-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"yearly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>11, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>52, :used_visits=>11, :pace=>-51, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>62, :reset_date=>"10-19-2022"}])
    end

    it "should correctly parse the pacing for patient 11998" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12001" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12002" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12003" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"05-20-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12006" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12009" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12013" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>37, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>23, :used_visits=>37, :pace=>6, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>31, :reset_date=>"04-13-2023"}])
    end

    it "should correctly parse the pacing for patient 12021" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12024" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-26-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>19, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>41, :used_visits=>19, :pace=>-24, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>43, :reset_date=>"01-26-2023"}])
    end

    it "should correctly parse the pacing for patient 12025" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-15-2022", :end_date=>"06-15-2023", :type_of_service=>"Speech Therapy", :frequency=>5, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>4, :pace=>1, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12026" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-15-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>5, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12027" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12030" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-18-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12043" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"04-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12047" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-17-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12049" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-18-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12050" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12051" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12054" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-19-2022", :end_date=>"04-18-2023", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>11, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"04-19-2022", :end_date=>"04-18-2023", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>11, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>19, :used_visits=>11, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>15, :reset_date=>"04-18-2023"}])
    end

    it "should correctly parse the pacing for patient 12058" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-19-2022", :end_date=>"04-18-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12061" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"04-17-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12063" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>19, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>51, :used_visits=>19, :pace=>-17, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>36, :reset_date=>"04-13-2023"}])
    end

    it "should correctly parse the pacing for patient 12066" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-08-2022", :end_date=>"11-04-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12075" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12077" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-07-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12080" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-16-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12088" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12093" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-26-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-26-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12095" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"04-26-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"04-26-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>40, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12098" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"08-07-2022", :type_of_service=>"Speech Therapy", :frequency=>62, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>16, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"08-08-2022", :end_date=>"05-12-2023", :type_of_service=>"Speech Therapy", :frequency=>62, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>16, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>56, :used_visits=>16, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>18, :reset_date=>"05-12-2023"}])
    end

    it "should correctly parse the pacing for patient 12099" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12100" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"11-09-2022", :type_of_service=>"Speech Therapy", :frequency=>62, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>14, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>48, :used_visits=>14, :pace=>-43, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>57, :reset_date=>"11-09-2022"}])
    end

    it "should correctly parse the pacing for patient 12111" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12117" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12118" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-18-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12124" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-03-2022", :end_date=>"05-03-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12131" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"05-23-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-20-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12134" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>17, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>15, :used_visits=>17, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>16, :reset_date=>"04-22-2023"}])
    end

    it "should correctly parse the pacing for patient 12138" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Speech Therapy", :frequency=>62, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>10, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>61, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"10-05-2023"}])
    end

    it "should correctly parse the pacing for patient 12148" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12153" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"10-20-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12154" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12155" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12157" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12158" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12159" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12162" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-03-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12166" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12173" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Speech Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>31, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>60, :used_visits=>31, :pace=>-9, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>40, :reset_date=>"05-09-2023"}])
    end

    it "should correctly parse the pacing for patient 12181" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>64, :used_visits=>6, :pace=>-25, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>31, :reset_date=>"05-06-2023"}])
    end

    it "should correctly parse the pacing for patient 12186" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12195" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-29-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12197" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-02-2022", :end_date=>"06-01-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12198" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"05-24-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12206" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12225" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12226" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12227" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-15-2022", :end_date=>"05-12-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12229" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-15-2022", :end_date=>"12-15-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-15-2022", :end_date=>"12-15-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12231" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12233" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12234" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>11, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>59, :used_visits=>11, :pace=>-8, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>19, :reset_date=>"05-19-2023"}])
    end

    it "should correctly parse the pacing for patient 12238" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12244" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12245" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12246" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-11-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12247" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-15-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12248" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"11-18-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12251" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"05-24-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"05-24-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12252" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"05-23-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12255" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-15-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12264" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12266" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-02-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12270" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-29-2022", :end_date=>"06-29-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12272" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-29-2022", :end_date=>"06-29-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12274" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Physical Therapy", :frequency=>10, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>13, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>9, :used_visits=>1, :pace=>1, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"09-29-2023"}])
    end

    it "should correctly parse the pacing for patient 12276" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"04-06-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"04-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12279" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"07-31-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"03-07-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"03-07-2023"}])
    end

    it "should correctly parse the pacing for patient 12280" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-20-2021", :end_date=>"10-20-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12281" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-04-2021", :end_date=>"11-04-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12282" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12283" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"05-17-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12284" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-11-2022", :end_date=>"10-11-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"10-11-2022", :end_date=>"10-11-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12285" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-12-2022", :end_date=>"10-12-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12287" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12288" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-12-2022", :end_date=>"10-12-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12289" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-12-2022", :end_date=>"10-12-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12290" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"07-30-2022", :end_date=>"07-29-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12291" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12295" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-05-2022", :end_date=>"02-11-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-05-2022", :end_date=>"02-11-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-05-2022", :end_date=>"02-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12297" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"03-10-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12299" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"11-30-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"11-30-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"11-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"11-30-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12302" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-18-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12303" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"04-21-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12304" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12305" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12306" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-18-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12307" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-26-2022", :end_date=>"09-26-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12308" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-05-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12309" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12310" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12311" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12312" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12313" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12314" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12318" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12319" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"11-16-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"11-16-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12320" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12321" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"01-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"01-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"01-27-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"01-27-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12323" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"01-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12324" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"12-09-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"12-09-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12325" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12326" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"07-31-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"07-31-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"07-31-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"02-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"02-07-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"02-07-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12327" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>0, :used_visits=>1, :pace=>0, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12329" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"03-29-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"03-29-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12330" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-20-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12332" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-11-2022", :end_date=>"08-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-11-2022", :end_date=>"10-11-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"10-11-2022", :end_date=>"08-11-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12333" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-27-2021", :end_date=>"10-27-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12334" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12335" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-21-2022", :end_date=>"12-03-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12336" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-20-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"12-01-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12337" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-17-2021", :end_date=>"12-17-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12338" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-14-2022", :end_date=>"06-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12339" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"08-12-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"08-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12340" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-20-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"02-09-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"02-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"02-09-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12342" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12344" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12346" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12348" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12350" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12351" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12353" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-04-2021", :end_date=>"11-04-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12355" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-03-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12357" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12358" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12359" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12360" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"12-15-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>0, :used_visits=>1, :pace=>0, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12361" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Physical Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>22, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>28, :used_visits=>2, :pace=>1, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"09-30-2023"}])
    end

    it "should correctly parse the pacing for patient 12362" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"10-28-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12363" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12364" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"12-08-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12365" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Physical Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12366" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12367" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12368" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12371" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12373" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>0, :used_visits=>1, :pace=>1, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12376" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12377" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"05-20-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12378" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"10-28-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"10-28-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12379" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"03-01-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"03-01-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"05-20-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"03-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12380" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"01-26-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12381" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-06-2022", :end_date=>"01-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"01-06-2022", :end_date=>"01-06-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"01-06-2022", :end_date=>"01-06-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12382" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"04-14-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12383" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-04-2022", :end_date=>"01-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12384" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-21-2022", :end_date=>"01-10-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12389" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12390" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"01-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12391" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"02-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"02-08-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"02-08-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12392" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-06-2022", :end_date=>"04-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12394" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12401" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12402" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12403" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12404" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-05-2021", :end_date=>"11-04-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12405" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>60, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>60, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12406" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12407" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"11-01-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12410" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-04-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12411" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-03-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12412" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12413" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-23-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12414" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12418" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>80, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"09-19-2023"}])
    end

    it "should correctly parse the pacing for patient 12419" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12420" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12421" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-02-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12422" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Physical Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12423" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12424" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12425" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12427" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-12-2022", :end_date=>"10-12-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12428" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12429" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12430" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12431" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12432" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12434" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-02-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12435" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12436" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12437" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"08-15-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"08-15-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12438" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12439" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"03-08-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12441" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-01-2021", :end_date=>"11-01-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12442" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12443" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12444" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12445" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12447" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12448" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12449" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12451" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12452" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-06-2021", :end_date=>"12-06-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12454" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12456" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12457" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-19-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12458" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12459" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"11-29-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12460" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12461" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-06-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-06-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12463" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"11-18-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12464" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"10-21-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12465" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-20-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12466" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12467" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"05-20-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"03-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12469" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12473" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>42, :used_visits=>1, :pace=>-22, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>23, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12474" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"11-15-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"11-15-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"11-15-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12475" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12477" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-09-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-09-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12478" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12480" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-12-2022", :end_date=>"10-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12481" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"01-13-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"01-13-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"01-13-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12482" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12483" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12484" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"01-20-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"01-20-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12485" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-10-2022", :end_date=>"04-19-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-10-2022", :end_date=>"04-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12486" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12487" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"04-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12488" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12489" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-22-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-22-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12491" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12492" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12493" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Physical Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>0, :used_visits=>2, :pace=>1, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12494" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12495" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"04-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"05-20-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-27-2023", :type_of_service=>"Physical Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12496" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12498" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>0, :used_visits=>1, :pace=>0, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12499" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12500" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12501" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"10-28-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12503" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"03-03-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12505" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"03-29-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"03-29-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12506" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12507" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12509" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12510" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-13-2022", :end_date=>"07-31-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"01-13-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-13-2022", :end_date=>"07-31-2022", :type_of_service=>"Physical Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"01-13-2023", :type_of_service=>"Physical Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-13-2022", :end_date=>"07-31-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"01-13-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12513" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"12-13-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"12-13-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12514" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12515" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"02-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12516" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-15-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-15-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-15-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12527" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12529" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12532" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12534" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-03-2022", :end_date=>"02-03-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12535" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12537" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12538" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12539" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12541" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12542" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"10-28-2022", :type_of_service=>"Physical Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"10-28-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>2, :pace=>0, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12543" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12544" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"02-03-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12545" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-18-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-18-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-18-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12546" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12548" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-20-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-20-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>10, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"09-20-2023"}])
    end

    it "should correctly parse the pacing for patient 12549" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-25-2022", :end_date=>"02-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12550" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"yearly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"02-17-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12551" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>0, :used_visits=>1, :pace=>0, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12553" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"03-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end
  end
end