require 'spec_helper'
require 'date'

RSpec.describe Pacing::Pacer do
  describe "Cue based specs" do
    it "should correctly parse the pacing for patient 8174" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-07-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8179" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-16-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-16-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8181" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-25-2021", :end_date=>"10-25-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8189" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-04-2022", :end_date=>"05-26-2022", :type_of_service=>"Language Therapy", :frequency=>80, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>37, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"08-04-2022", :end_date=>"01-04-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>37, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>105, :used_visits=>13, :pace=>-44, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>57, :reset_date=>"01-04-2023"}])
    end

    it "should correctly parse the pacing for patient 8190" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>112, :used_visits=>6, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>11, :reset_date=>"09-14-2023"}])
    end

    it "should correctly parse the pacing for patient 8191" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-29-2021", :end_date=>"10-29-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>61, :used_visits=>57, :pace=>-57, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>114, :reset_date=>"10-29-2022"}])
    end

    it "should correctly parse the pacing for patient 8200" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8208" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-02-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8212" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8213" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-23-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8216" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8225" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"02-04-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8226" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-29-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8231" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8243" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-31-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8267" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-30-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8273" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8279" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-04-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-04-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>4, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8285" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-03-2022", :end_date=>"02-03-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8303" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-11-2022", :end_date=>"08-11-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-11-2022", :end_date=>"08-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8312" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"04-27-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8325" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Language Therapy", :frequency=>50, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>35, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>54, :used_visits=>6, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"09-16-2023"}])
    end

    it "should correctly parse the pacing for patient 8331" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>49, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>59, :pace=>-6, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>65, :reset_date=>"11-10-2022"}])
    end

    it "should correctly parse the pacing for patient 8334" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8347" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>84, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>84, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>55, :used_visits=>53, :pace=>-25, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>78, :reset_date=>"01-26-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>11, :used_visits=>21, :pace=>-2, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>23, :reset_date=>"01-26-2023"}])
    end

    it "should correctly parse the pacing for patient 8348" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-20-2021", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8350" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-19-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8356" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8398" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"03-03-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8400" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"01-25-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"01-25-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8402" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8404" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"03-25-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8407" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"11-15-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-15-2022", :type_of_service=>"Occupation Therapy", :frequency=>9, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>34, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>6, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"11-15-2022"}])
    end

    it "should correctly parse the pacing for patient 8409" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8410" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-18-2022", :end_date=>"01-31-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8411" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>55, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>79, :used_visits=>29, :pace=>-28, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>57, :reset_date=>"04-08-2023"}])
    end

    it "should correctly parse the pacing for patient 8413" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>49, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>91, :used_visits=>27, :pace=>-63, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>90, :reset_date=>"12-13-2022"}])
    end

    it "should correctly parse the pacing for patient 8430" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-09-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-09-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8432" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8435" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"03-31-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 8440" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-21-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-21-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8445" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>65, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>36, :used_visits=>44, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>45, :reset_date=>"03-24-2023"}])
    end

    it "should correctly parse the pacing for patient 8447" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8448" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>65, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>85, :used_visits=>23, :pace=>-25, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>48, :reset_date=>"05-06-2023"}])
    end

    it "should correctly parse the pacing for patient 8449" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>56, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>59, :used_visits=>59, :pace=>-42, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>101, :reset_date=>"12-08-2022"}])
    end

    it "should correctly parse the pacing for patient 8454" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8457" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8460" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-22-2021", :end_date=>"10-22-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-22-2021", :end_date=>"10-22-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8461" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8465" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8474" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>63, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>27, :used_visits=>43, :pace=>-20, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>63, :reset_date=>"11-10-2022"}])
    end

    it "should correctly parse the pacing for patient 8477" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8499" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-09-2022", :end_date=>"08-09-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8500" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 8517" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-01-2022", :end_date=>"12-08-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"07-29-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 8532" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-06-2022", :end_date=>"01-06-2023", :type_of_service=>"Language Therapy", :frequency=>50, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>44, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"01-06-2022", :end_date=>"01-06-2023", :type_of_service=>"Speech Therapy", :frequency=>50, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>44, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>16, :used_visits=>44, :pace=>-2, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>46, :reset_date=>"01-06-2023"}])
    end

    it "should correctly parse the pacing for patient 8537" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-19-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8539" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8552" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8556" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-14-2022", :end_date=>"07-07-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8562" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8566" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8571" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"08-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"08-08-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8573" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8574" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"05-27-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-08-2022", :end_date=>"03-24-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8576" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"03-03-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8585" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8588" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8597" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"01-27-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>47, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>46, :used_visits=>34, :pace=>-21, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>55, :reset_date=>"01-27-2023"}])
    end

    it "should correctly parse the pacing for patient 8599" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8602" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 8609" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-18-2021", :end_date=>"10-18-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-18-2021", :end_date=>"10-18-2022", :type_of_service=>"Occupation Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8610" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>83, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>56, :used_visits=>62, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>73, :reset_date=>"03-04-2023"}])
    end

    it "should correctly parse the pacing for patient 8616" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>33, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>28, :used_visits=>14, :pace=>-9, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>23, :reset_date=>"03-30-2023"}])
    end

    it "should correctly parse the pacing for patient 8620" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8623" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"03-31-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>25, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>16, :used_visits=>16, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>17, :reset_date=>"03-31-2023"}])
    end

    it "should correctly parse the pacing for patient 8626" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>55, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>52, :used_visits=>56, :pace=>-35, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>91, :reset_date=>"12-14-2022"}])
    end

    it "should correctly parse the pacing for patient 8630" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"03-16-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8633" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"03-21-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8640" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Speech Therapy", :frequency=>16, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>20, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Language Therapy", :frequency=>16, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>20, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>22, :used_visits=>20, :pace=>-10, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>30, :reset_date=>"01-27-2023"}])
    end

    it "should correctly parse the pacing for patient 8643" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>46, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>46, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>89, :used_visits=>19, :pace=>-26, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>45, :reset_date=>"05-17-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>24, :used_visits=>8, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>13, :reset_date=>"05-17-2023"}])
    end

    it "should correctly parse the pacing for patient 8653" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8654" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-05-2022", :end_date=>"05-20-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-05-2022", :end_date=>"05-20-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8661" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8664" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-07-2022", :end_date=>"10-07-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-07-2022", :end_date=>"10-07-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8672" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"04-04-2023", :type_of_service=>"Speech Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>47, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>22, :used_visits=>33, :pace=>3, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>30, :reset_date=>"04-04-2023"}])
    end

    it "should correctly parse the pacing for patient 8682" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"08-10-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"08-10-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 8683" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8690" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"05-24-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"03-10-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8693" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8700" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8702" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-06-2022", :end_date=>"04-06-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-06-2022", :end_date=>"04-06-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>14, :used_visits=>3, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8705" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 8707" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 8708" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8709" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8717" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8718" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8721" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8724" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8726" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8728" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"11-15-2022", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>46, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>34, :used_visits=>36, :pace=>-26, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>62, :reset_date=>"11-15-2022"}])
    end

    it "should correctly parse the pacing for patient 8732" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-19-2022", :end_date=>"04-19-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-19-2022", :end_date=>"04-19-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8734" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-02-2022", :end_date=>"06-02-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-02-2022", :end_date=>"06-02-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-02-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-02-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>6, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8735" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8739" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8740" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8742" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"05-13-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-13-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8743" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-02-2022", :end_date=>"06-02-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-02-2022", :end_date=>"06-02-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8746" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8748" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8755" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"04-04-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8757" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-26-2022", :end_date=>"04-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8758" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8767" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8773" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8777" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8778" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-05-2021", :end_date=>"11-05-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8779" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 8781" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8782" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8784" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8788" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8789" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8790" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8792" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"10-06-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8795" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8796" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8798" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8801" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8802" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8804" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8805" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8806" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8807" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-22-2021", :end_date=>"10-22-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8813" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>4, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8816" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-11-2021", :end_date=>"11-11-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-11-2021", :end_date=>"11-11-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8819" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>33, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>68, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"09-21-2023"}])
    end

    it "should correctly parse the pacing for patient 8820" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-09-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-09-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>4, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8821" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8826" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-25-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8830" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-17-2022", :type_of_service=>"Speech Therapy", :frequency=>120, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>47, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>19, :used_visits=>51, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>64, :reset_date=>"11-17-2022"}])
    end

    it "should correctly parse the pacing for patient 8833" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8838" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>23, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>56, :used_visits=>14, :pace=>-19, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>33, :reset_date=>"04-28-2023"}])
    end

    it "should correctly parse the pacing for patient 8852" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8854" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-22-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8858" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-07-2023", :type_of_service=>"Speech Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>44, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>91, :used_visits=>9, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>11, :reset_date=>"09-07-2023"}])
    end

    it "should correctly parse the pacing for patient 8860" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>57, :used_visits=>13, :pace=>-19, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>32, :reset_date=>"05-04-2023"}])
    end

    it "should correctly parse the pacing for patient 8878" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8879" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"08-16-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8888" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-25-2021", :end_date=>"10-24-2022", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>38, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>17, :used_visits=>53, :pace=>-16, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>69, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 8891" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-06-2023", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>40, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>52, :used_visits=>18, :pace=>-19, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>37, :reset_date=>"04-06-2023"}])
    end

    it "should correctly parse the pacing for patient 8892" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"03-25-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>63, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"03-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>63, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>89, :used_visits=>19, :pace=>-36, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>55, :reset_date=>"03-25-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>25, :used_visits=>7, :pace=>-9, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>16, :reset_date=>"03-25-2023"}])
    end

    it "should correctly parse the pacing for patient 8901" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>21, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-01-2023", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>21, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>19, :used_visits=>21, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>28, :reset_date=>"02-01-2023"}])
    end

    it "should correctly parse the pacing for patient 8905" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8915" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8927" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-03-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8930" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8932" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8934" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 8936" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"11-05-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8939" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-27-2021", :end_date=>"10-26-2022", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>40, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>16, :used_visits=>54, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>68, :reset_date=>"10-26-2022"}])
    end

    it "should correctly parse the pacing for patient 8940" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>60, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-09-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>30, :used_visits=>10, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>24, :reset_date=>"03-09-2023"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 8941" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>48, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-23-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>48, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>21, :used_visits=>9, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>22, :reset_date=>"01-23-2023"}, {:discipline=>"Speech Therapy", :remaining_visits=>26, :used_visits=>34, :pace=>-10, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>44, :reset_date=>"01-23-2023"}])
    end

    it "should correctly parse the pacing for patient 8948" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-08-2022", :end_date=>"08-08-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-08-2022", :end_date=>"08-08-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8956" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>5, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>5, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8970" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"10-20-2022", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>23, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>31, :used_visits=>9, :pace=>-30, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>39, :reset_date=>"10-20-2022"}])
    end

    it "should correctly parse the pacing for patient 8972" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-21-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>40, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>40, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>40, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"09-21-2023"}, {:discipline=>"Speech Therapy", :remaining_visits=>68, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"09-21-2023"}])
    end

    it "should correctly parse the pacing for patient 8973" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-22-2021", :end_date=>"10-21-2022", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>54, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"10-22-2021", :end_date=>"10-21-2022", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>54, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>19, :used_visits=>51, :pace=>-18, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>69, :reset_date=>"10-21-2022"}])
    end

    it "should correctly parse the pacing for patient 8989" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8991" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8994" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 8995" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 8997" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-28-2022", :end_date=>"02-28-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9006" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9007" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"03-07-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"03-07-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9011" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9014" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>10, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9015" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9016" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-11-2021", :end_date=>"11-11-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9018" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-14-2022", :end_date=>"02-14-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-14-2022", :end_date=>"02-14-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>4, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9020" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9024" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9025" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9028" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9030" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-19-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9031" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-28-2022", :end_date=>"01-28-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9033" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9034" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9035" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-22-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9036" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9040" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>25, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>29, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>28, :reset_date=>"12-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9042" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"12-06-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9044" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9047" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"05-13-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"05-13-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9048" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9049" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9052" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"11-03-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9054" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-17-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9057" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9058" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9064" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9065" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-02-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9071" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-02-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9072" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9074" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9075" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"03-24-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9076" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9078" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9084" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9086" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9087" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9092" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-20-2022", :end_date=>"04-20-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9102" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"05-13-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"05-13-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-25-2022", :end_date=>"06-22-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-25-2022", :end_date=>"06-22-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9107" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9109" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-20-2021", :end_date=>"10-20-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9119" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 9122" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 9123" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"10-06-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9124" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-02-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9125" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9127" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9130" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-22-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9134" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9137" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9138" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"01-25-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9142" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9144" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-21-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9146" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9147" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"02-07-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>9, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9157" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>107, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>107, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>40, :used_visits=>78, :pace=>-21, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>99, :reset_date=>"12-14-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>9, :used_visits=>33, :pace=>-2, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>35, :reset_date=>"12-14-2022"}])
    end

    it "should correctly parse the pacing for patient 9160" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"01-25-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9161" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"11-11-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9162" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9163" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9164" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9174" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>29, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>9, :used_visits=>23, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>22, :reset_date=>"02-08-2023"}])
    end

    it "should correctly parse the pacing for patient 9179" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"03-29-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"03-29-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9183" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9193" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9196" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-23-2022", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9197" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9199" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9200" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9201" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-18-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9202" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-15-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9204" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9218" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9219" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Language Therapy", :frequency=>50, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>27, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Speech Therapy", :frequency=>50, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>27, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-06-2022", :end_date=>"06-24-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-06-2022", :end_date=>"06-24-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>16, :used_visits=>34, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>48, :reset_date=>"11-02-2022"}])
    end

    it "should correctly parse the pacing for patient 9220" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-15-2023", :type_of_service=>"Language Therapy", :frequency=>20, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>10, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>17, :used_visits=>3, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"05-15-2023"}])
    end

    it "should correctly parse the pacing for patient 9223" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9227" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9240" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9248" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9253" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"03-25-2023", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>28, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>23, :used_visits=>19, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>24, :reset_date=>"03-25-2023"}])
    end

    it "should correctly parse the pacing for patient 9257" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9258" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-29-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>56, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-29-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>46, :used_visits=>30, :pace=>-12, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>42, :reset_date=>"03-29-2023"}])
    end

    it "should correctly parse the pacing for patient 9259" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9262" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9266" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Occupation Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>29, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-28-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>12, :used_visits=>30, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>36, :reset_date=>"12-08-2022"}])
    end

    it "should correctly parse the pacing for patient 9267" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9269" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9273" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9280" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"02-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9289" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9293" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-23-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9294" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-28-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9301" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9309" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>46, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>60, :used_visits=>20, :pace=>-16, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>36, :reset_date=>"05-05-2023"}])
    end

    it "should correctly parse the pacing for patient 9314" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9315" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9316" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9321" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9327" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>35, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>44, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Speech Therapy", :frequency=>35, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>44, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"06-06-2022", :end_date=>"06-24-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"06-06-2022", :end_date=>"06-24-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>60, :used_visits=>20, :pace=>-15, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>35, :reset_date=>"05-10-2023"}])
    end

    it "should correctly parse the pacing for patient 9328" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>35, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Speech Therapy", :frequency=>35, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>60, :used_visits=>20, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>34, :reset_date=>"05-17-2023"}])
    end

    it "should correctly parse the pacing for patient 9330" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-15-2023", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-15-2023", :type_of_service=>"Speech Therapy", :frequency=>40, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>58, :used_visits=>22, :pace=>-12, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>34, :reset_date=>"05-15-2023"}])
    end

    it "should correctly parse the pacing for patient 9391" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-10-2022", :end_date=>"01-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-10-2022", :end_date=>"01-10-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9412" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9413" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9416" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"05-13-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9432" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"04-01-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9473" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>47, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>29, :used_visits=>51, :pace=>-19, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>70, :reset_date=>"12-02-2022"}])
    end

    it "should correctly parse the pacing for patient 9474" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>57, :used_visits=>23, :pace=>-21, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>44, :reset_date=>"04-01-2023"}])
    end

    it "should correctly parse the pacing for patient 9486" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9487" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9506" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-25-2022", :end_date=>"12-15-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9508" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"02-11-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-07-2022", :end_date=>"02-11-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9522" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Language Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>64, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>22, :used_visits=>10, :pace=>5, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"08-26-2023"}])
    end

    it "should correctly parse the pacing for patient 9524" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"08-12-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"08-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9534" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9539" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9552" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-23-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>49, :used_visits=>21, :pace=>-19, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>40, :reset_date=>"03-23-2023"}])
    end

    it "should correctly parse the pacing for patient 9565" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9566" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-04-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9568" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9569" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"03-31-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9574" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-04-2021", :end_date=>"11-03-2022", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>38, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"11-04-2021", :end_date=>"11-03-2022", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>38, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>22, :used_visits=>48, :pace=>-19, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>67, :reset_date=>"11-03-2022"}])
    end

    it "should correctly parse the pacing for patient 9576" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-10-2022", :end_date=>"10-10-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-10-2022", :end_date=>"10-10-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9583" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>61, :used_visits=>9, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>10, :reset_date=>"08-29-2023"}])
    end

    it "should correctly parse the pacing for patient 9585" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>69, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>16, :used_visits=>75, :pace=>-5, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>80, :reset_date=>"12-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9586" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>54, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>54, :used_visits=>26, :pace=>-12, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>38, :reset_date=>"04-28-2023"}])
    end

    it "should correctly parse the pacing for patient 9587" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>51, :used_visits=>9, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"08-29-2023"}])
    end

    it "should correctly parse the pacing for patient 9590" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9596" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"01-24-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>39, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>36, :used_visits=>34, :pace=>-17, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>51, :reset_date=>"01-24-2023"}])
    end

    it "should correctly parse the pacing for patient 9600" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-18-2022", :type_of_service=>"Occupation Therapy", :frequency=>10, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>12, :used_visits=>8, :pace=>-12, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>20, :reset_date=>"10-18-2022"}])
    end

    it "should correctly parse the pacing for patient 9613" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>18, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>18, :used_visits=>22, :pace=>-16, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>38, :reset_date=>"11-03-2022"}])
    end

    it "should correctly parse the pacing for patient 9615" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9619" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9635" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-18-2022", :end_date=>"08-18-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9641" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 9644" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9653" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-15-2023", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-15-2023", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>58, :used_visits=>12, :pace=>-18, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>30, :reset_date=>"05-15-2023"}])
    end

    it "should correctly parse the pacing for patient 9654" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-15-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>57, :used_visits=>13, :pace=>-17, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>30, :reset_date=>"05-15-2023"}])
    end

    it "should correctly parse the pacing for patient 9657" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9660" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-19-2023", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>46, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>64, :used_visits=>6, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"09-19-2023"}])
    end

    it "should correctly parse the pacing for patient 9661" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9663" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>58, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>58, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>46, :used_visits=>14, :pace=>5, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"08-26-2023"}])
    end

    it "should correctly parse the pacing for patient 9665" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-22-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-22-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9667" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9670" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-27-2021", :end_date=>"10-26-2022", :type_of_service=>"Language Therapy", :frequency=>45, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>72, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"10-27-2021", :end_date=>"10-26-2022", :type_of_service=>"Speech Therapy", :frequency=>45, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>72, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"10-27-2021", :end_date=>"10-26-2022", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>72, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>16, :used_visits=>74, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>88, :reset_date=>"10-26-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>10, :used_visits=>20, :pace=>-9, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>29, :reset_date=>"10-26-2022"}])
    end

    it "should correctly parse the pacing for patient 9671" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>61, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>61, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>38, :used_visits=>32, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>45, :reset_date=>"02-24-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>31, :used_visits=>9, :pace=>-17, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>26, :reset_date=>"02-24-2023"}])
    end

    it "should correctly parse the pacing for patient 9676" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9677" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-05-2021", :end_date=>"11-05-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9678" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9679" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9680" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9682" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"02-04-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"02-04-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9684" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9685" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9687" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-18-2022", :end_date=>"03-18-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9688" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-30-2021", :end_date=>"10-29-2022", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>57, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"10-30-2021", :end_date=>"10-29-2022", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>57, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>11, :used_visits=>19, :pace=>-10, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>29, :reset_date=>"10-29-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>35, :used_visits=>55, :pace=>-32, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>87, :reset_date=>"10-29-2022"}])
    end

    it "should correctly parse the pacing for patient 9689" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9692" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9693" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-14-2022", :end_date=>"01-18-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>61, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-14-2022", :end_date=>"01-18-2023", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>61, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>21, :used_visits=>9, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>22, :reset_date=>"01-18-2023"}, {:discipline=>"Speech Therapy", :remaining_visits=>46, :used_visits=>44, :pace=>-21, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>65, :reset_date=>"01-18-2023"}])
    end

    it "should correctly parse the pacing for patient 9696" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9698" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9699" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"02-16-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9701" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9702" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>10, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9703" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>20, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>63, :used_visits=>7, :pace=>-26, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>33, :reset_date=>"04-28-2023"}])
    end

    it "should correctly parse the pacing for patient 9704" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"11-19-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"07-31-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9705" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"04-26-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>53, :used_visits=>17, :pace=>-16, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>33, :reset_date=>"04-26-2023"}])
    end

    it "should correctly parse the pacing for patient 9707" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>67, :used_visits=>3, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"09-30-2023"}])
    end

    it "should correctly parse the pacing for patient 9709" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"03-31-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>36, :used_visits=>24, :pace=>-9, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>33, :reset_date=>"03-31-2023"}])
    end

    it "should correctly parse the pacing for patient 9710" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>22, :used_visits=>48, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>62, :reset_date=>"11-29-2022"}])
    end

    it "should correctly parse the pacing for patient 9711" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Speech Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>22, :used_visits=>48, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>61, :reset_date=>"12-02-2022"}])
    end

    it "should correctly parse the pacing for patient 9714" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"01-31-2023", :type_of_service=>"Language Therapy", :frequency=>45, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"01-31-2023", :type_of_service=>"Speech Therapy", :frequency=>45, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>44, :used_visits=>46, :pace=>-18, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>64, :reset_date=>"01-31-2023"}])
    end

    it "should correctly parse the pacing for patient 9719" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-26-2022", :end_date=>"09-21-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9724" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-23-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-23-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-23-2023", :type_of_service=>"Physical Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9728" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9730" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-15-2022", :end_date=>"04-14-2023", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>60, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>69, :used_visits=>31, :pace=>-20, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>51, :reset_date=>"04-14-2023"}])
    end

    it "should correctly parse the pacing for patient 9731" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-03-2023", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>67, :used_visits=>33, :pace=>-29, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>62, :reset_date=>"03-03-2023"}])
    end

    it "should correctly parse the pacing for patient 9733" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"05-12-2023", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>38, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>75, :used_visits=>15, :pace=>-24, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>39, :reset_date=>"05-12-2023"}])
    end

    it "should correctly parse the pacing for patient 9734" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>46, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-14-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>46, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>21, :used_visits=>9, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>20, :reset_date=>"02-14-2023"}, {:discipline=>"Speech Therapy", :remaining_visits=>33, :used_visits=>27, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>40, :reset_date=>"02-14-2023"}])
    end

    it "should correctly parse the pacing for patient 9737" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>62, :used_visits=>8, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>10, :reset_date=>"08-25-2023"}])
    end

    it "should correctly parse the pacing for patient 9743" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9744" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9747" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-08-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9750" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9751" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-29-2022", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>57, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-29-2022", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>57, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>14, :used_visits=>16, :pace=>-10, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>26, :reset_date=>"11-29-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>14, :used_visits=>46, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>53, :reset_date=>"11-29-2022"}])
    end

    it "should correctly parse the pacing for patient 9752" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-18-2022", :end_date=>"03-18-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9758" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9759" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9760" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9761" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 9762" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9764" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9766" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"02-18-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9769" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>57, :used_visits=>43, :pace=>-25, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>68, :reset_date=>"02-10-2023"}])
    end

    it "should correctly parse the pacing for patient 9771" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-15-2022", :end_date=>"04-14-2023", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>53, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>70, :used_visits=>30, :pace=>-21, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>51, :reset_date=>"04-14-2023"}])
    end

    it "should correctly parse the pacing for patient 9772" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"05-22-2023", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>44, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>83, :used_visits=>17, :pace=>-24, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>41, :reset_date=>"05-22-2023"}])
    end

    it "should correctly parse the pacing for patient 9773" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-25-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>53, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-25-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>53, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>36, :used_visits=>4, :pace=>-15, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>19, :reset_date=>"04-25-2023"}, {:discipline=>"Speech Therapy", :remaining_visits=>53, :used_visits=>17, :pace=>-17, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>34, :reset_date=>"04-25-2023"}])
    end

    it "should correctly parse the pacing for patient 9774" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9776" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-20-2022", :end_date=>"01-20-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9777" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>59, :used_visits=>11, :pace=>4, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"09-13-2023"}])
    end

    it "should correctly parse the pacing for patient 9779" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Language Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>66, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>29, :used_visits=>36, :pace=>2, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>34, :reset_date=>"04-11-2023"}])
    end

    it "should correctly parse the pacing for patient 9787" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"08-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9788" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9790" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"11-01-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9792" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9799" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9800" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-11-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9824" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9828" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-07-2022", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>20, :used_visits=>50, :pace=>-16, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>66, :reset_date=>"11-07-2022"}])
    end

    it "should correctly parse the pacing for patient 9832" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"03-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>10, :interval=>"yearly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"03-30-2023", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"05-23-2022", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"03-30-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>18, :used_visits=>2, :pace=>-9, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>11, :reset_date=>"03-30-2023"}, {:discipline=>"Speech Therapy", :remaining_visits=>73, :used_visits=>27, :pace=>-28, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>55, :reset_date=>"03-30-2023"}])
    end

    it "should correctly parse the pacing for patient 9833" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>10, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9835" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-02-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-02-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9836" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-16-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-16-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9839" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9849" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>61, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>59, :used_visits=>11, :pace=>3, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"09-06-2023"}])
    end

    it "should correctly parse the pacing for patient 9857" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9864" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>12, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>18, :used_visits=>12, :pace=>-15, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>27, :reset_date=>"11-18-2022"}])
    end

    it "should correctly parse the pacing for patient 9868" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"05-24-2022", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>38, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([])
    end

    it "should correctly parse the pacing for patient 9869" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"05-22-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>44, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>62, :used_visits=>8, :pace=>-20, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>28, :reset_date=>"05-22-2023"}])
    end

    it "should correctly parse the pacing for patient 9871" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9875" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-16-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9890" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-11-2022", :end_date=>"08-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9893" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9894" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9901" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>65, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>25, :used_visits=>55, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>54, :reset_date=>"02-10-2023"}])
    end

    it "should correctly parse the pacing for patient 9902" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-10-2022", :end_date=>"01-10-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-10-2022", :end_date=>"01-10-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9907" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9922" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>71, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>104, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"09-28-2023"}])
    end

    it "should correctly parse the pacing for patient 9925" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 9926" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-18-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9929" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9930" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-03-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>61, :used_visits=>9, :pace=>-23, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>32, :reset_date=>"05-03-2023"}])
    end

    it "should correctly parse the pacing for patient 9931" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9932" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"02-01-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9933" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9940" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"02-18-2023", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>35, :used_visits=>5, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>12, :reset_date=>"02-18-2023"}])
    end

    it "should correctly parse the pacing for patient 9941" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-14-2022", :end_date=>"03-14-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9942" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-18-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>31, :used_visits=>39, :pace=>-13, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>52, :reset_date=>"01-18-2023"}])
    end

    it "should correctly parse the pacing for patient 9951" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-19-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-19-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9962" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-17-2022", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>23, :used_visits=>47, :pace=>-17, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>64, :reset_date=>"11-17-2022"}])
    end

    it "should correctly parse the pacing for patient 9965" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9970" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"05-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9972" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9982" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>50, :used_visits=>20, :pace=>-16, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>36, :reset_date=>"04-12-2023"}])
    end

    it "should correctly parse the pacing for patient 9989" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>45, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>40, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Speech Therapy", :frequency=>45, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>40, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>73, :used_visits=>27, :pace=>-33, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>60, :reset_date=>"03-10-2023"}])
    end

    it "should correctly parse the pacing for patient 9990" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"05-22-2023", :type_of_service=>"Speech Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>35, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>84, :used_visits=>16, :pace=>-25, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>41, :reset_date=>"05-22-2023"}])
    end

    it "should correctly parse the pacing for patient 9991" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-07-2022", :end_date=>"05-16-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-07-2022", :end_date=>"05-16-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 9995" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-11-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 9999" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-14-2022", :end_date=>"02-14-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10000" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10002" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10005" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10021" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>68, :used_visits=>2, :pace=>-27, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>29, :reset_date=>"05-17-2023"}])
    end

    it "should correctly parse the pacing for patient 10022" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"03-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>12, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>22, :used_visits=>8, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>19, :reset_date=>"03-03-2023"}])
    end

    it "should correctly parse the pacing for patient 10023" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10027" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-06-2022", :end_date=>"10-06-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10029" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10033" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-22-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>42, :used_visits=>28, :pace=>-12, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>40, :reset_date=>"03-22-2023"}])
    end

    it "should correctly parse the pacing for patient 10035" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10036" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-11-2023", :type_of_service=>"Language Therapy", :frequency=>45, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>58, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-11-2023", :type_of_service=>"Speech Therapy", :frequency=>45, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>58, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>83, :used_visits=>7, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"09-11-2023"}])
    end

    it "should correctly parse the pacing for patient 10040" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10041" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-11-2022", :end_date=>"08-11-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10045" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10053" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-18-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10062" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10064" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-02-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-02-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10065" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-05-2021", :end_date=>"11-04-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-05-2021", :end_date=>"11-04-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10068" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"03-21-2023", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>73, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"03-21-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>73, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>94, :used_visits=>6, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>17, :reset_date=>"03-21-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>38, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"03-21-2023"}])
    end

    it "should correctly parse the pacing for patient 10075" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>34, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>72, :used_visits=>8, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>11, :reset_date=>"08-26-2023"}])
    end

    it "should correctly parse the pacing for patient 10080" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>43, :used_visits=>38, :pace=>-17, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>55, :reset_date=>"02-10-2023"}])
    end

    it "should correctly parse the pacing for patient 10081" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Speech Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>36, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>42, :used_visits=>39, :pace=>-32, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>71, :reset_date=>"11-30-2022"}])
    end

    it "should correctly parse the pacing for patient 10082" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>40, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>37, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Speech Therapy", :frequency=>41, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>37, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>75, :used_visits=>16, :pace=>-25, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>41, :reset_date=>"05-05-2023"}])
    end

    it "should correctly parse the pacing for patient 10083" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>75, :used_visits=>5, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"09-09-2023"}])
    end

    it "should correctly parse the pacing for patient 10084" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"03-23-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>74, :used_visits=>34, :pace=>-27, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>61, :reset_date=>"03-23-2023"}])
    end

    it "should correctly parse the pacing for patient 10085" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>41, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>76, :used_visits=>4, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"09-07-2023"}])
    end

    it "should correctly parse the pacing for patient 10090" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>45, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>49, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>45, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>49, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>32, :used_visits=>58, :pace=>-24, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>82, :reset_date=>"11-18-2022"}])
    end

    it "should correctly parse the pacing for patient 10091" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>40, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>84, :used_visits=>16, :pace=>-28, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>44, :reset_date=>"05-10-2023"}])
    end

    it "should correctly parse the pacing for patient 10098" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-25-2021", :end_date=>"10-24-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10107" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"05-11-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10108" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-01-2021", :end_date=>"10-31-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-01-2021", :end_date=>"10-31-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10109" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"04-04-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10113" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>37, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>24, :used_visits=>8, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>13, :reset_date=>"05-17-2023"}])
    end

    it "should correctly parse the pacing for patient 10116" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10121" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>63, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>93, :used_visits=>25, :pace=>-28, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>53, :reset_date=>"05-06-2023"}])
    end

    it "should correctly parse the pacing for patient 10122" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>69, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>67, :used_visits=>51, :pace=>-25, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>76, :reset_date=>"02-23-2023"}])
    end

    it "should correctly parse the pacing for patient 10123" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>58, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>97, :used_visits=>21, :pace=>-35, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>56, :reset_date=>"04-26-2023"}])
    end

    it "should correctly parse the pacing for patient 10124" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Language Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>25, :used_visits=>7, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>14, :reset_date=>"05-09-2023"}])
    end

    it "should correctly parse the pacing for patient 10127" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>76, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>36, :used_visits=>82, :pace=>-21, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>103, :reset_date=>"12-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10128" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>63, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>63, :used_visits=>55, :pace=>-29, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>84, :reset_date=>"01-31-2023"}])
    end

    it "should correctly parse the pacing for patient 10130" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-31-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>67, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>59, :used_visits=>59, :pace=>-25, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>84, :reset_date=>"01-31-2023"}])
    end

    it "should correctly parse the pacing for patient 10131" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"04-27-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>63, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>84, :used_visits=>24, :pace=>-27, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>51, :reset_date=>"04-27-2023"}])
    end

    it "should correctly parse the pacing for patient 10139" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10141" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"03-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10145" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>62, :used_visits=>19, :pace=>-20, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>39, :reset_date=>"04-22-2023"}])
    end

    it "should correctly parse the pacing for patient 10147" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>35, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>57, :used_visits=>24, :pace=>-25, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>49, :reset_date=>"03-08-2023"}])
    end

    it "should correctly parse the pacing for patient 10148" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-05-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10155" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10159" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"03-31-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10160" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"02-10-2023", :type_of_service=>"Speech Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>19, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>62, :used_visits=>19, :pace=>-36, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>55, :reset_date=>"02-10-2023"}])
    end

    it "should correctly parse the pacing for patient 10162" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"02-21-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10179" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10183" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10186" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10194" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"03-21-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10195" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"05-25-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10201" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10229" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-25-2021", :end_date=>"10-25-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10231" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-09-2021", :end_date=>"11-09-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10234" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"05-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>13, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>13, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>40, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"05-05-2023"}, {:discipline=>"Speech Therapy", :remaining_visits=>70, :used_visits=>0, :pace=>-12, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>12, :reset_date=>"05-05-2023"}])
    end

    it "should correctly parse the pacing for patient 10238" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-05-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"08-04-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10272" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-09-2022", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>70, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-09-2022", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>70, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>24, :used_visits=>16, :pace=>-21, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>37, :reset_date=>"11-09-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>37, :used_visits=>63, :pace=>-30, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>93, :reset_date=>"11-09-2022"}])
    end

    it "should correctly parse the pacing for patient 10273" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-25-2022", :end_date=>"03-24-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>45, :used_visits=>25, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>39, :reset_date=>"03-24-2023"}])
    end

    it "should correctly parse the pacing for patient 10289" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"yearly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>13, :used_visits=>1, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"09-11-2023"}])
    end

    it "should correctly parse the pacing for patient 10290" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>14, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>36, :used_visits=>4, :pace=>-16, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>20, :reset_date=>"04-13-2023"}])
    end

    it "should correctly parse the pacing for patient 10311" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-02-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>53, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>71, :used_visits=>9, :pace=>-1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>10, :reset_date=>"09-02-2023"}])
    end

    it "should correctly parse the pacing for patient 10320" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>10, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>58, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-01-2023", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>58, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"03-01-2023"}, {:discipline=>"Speech Therapy", :remaining_visits=>50, :used_visits=>40, :pace=>-17, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>57, :reset_date=>"03-01-2023"}])
    end

    it "should correctly parse the pacing for patient 10322" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-26-2022", :end_date=>"05-23-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10325" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>9, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10331" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-16-2021", :end_date=>"12-16-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10336" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10338" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10339" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10340" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10341" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10345" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-15-2022", :end_date=>"03-15-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-15-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"07-01-2022", :end_date=>"03-15-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10362" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"11-02-2022", :type_of_service=>"Speech Therapy", :frequency=>16, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Speech Therapy", :frequency=>16, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>4, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>8, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10363" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-21-2022", :end_date=>"12-02-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"12-02-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10369" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10370" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10372" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10374" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-28-2022", :end_date=>"01-28-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10375" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10377" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10378" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-14-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10381" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10385" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10388" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-18-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10391" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10392" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10402" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>42, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>72, :used_visits=>18, :pace=>-23, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>41, :reset_date=>"05-04-2023"}])
    end

    it "should correctly parse the pacing for patient 10407" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10412" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10417" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10420" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-06-2023", :type_of_service=>"Language Therapy", :frequency=>16, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"08-01-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>4, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10421" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10422" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-02-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10425" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10430" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>58, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-14-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>58, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>38, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"09-14-2023"}, {:discipline=>"Speech Therapy", :remaining_visits=>63, :used_visits=>7, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"09-14-2023"}])
    end

    it "should correctly parse the pacing for patient 10432" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-10-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10433" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-01-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-01-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10435" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-18-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10440" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"08-01-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"08-01-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"01-24-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10441" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-30-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-30-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10442" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>0, :used_visits=>1, :pace=>0, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10443" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10444" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"08-15-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"08-15-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10446" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-20-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10447" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10448" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-30-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10450" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-07-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10451" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-21-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10455" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"04-06-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"04-06-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"04-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10458" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"04-03-2023", :type_of_service=>"Speech and Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10460" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-07-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-07-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10465" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-26-2022", :end_date=>"09-25-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10466" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-04-2022", :end_date=>"10-03-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10471" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-14-2022", :end_date=>"03-13-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-14-2022", :end_date=>"03-13-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10475" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10476" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-27-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10478" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-02-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10481" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10482" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10486" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-01-2022", :end_date=>"04-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10490" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10492" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-23-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10499" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10501" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10507" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>18, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>18, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>39, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"10-03-2023"}, {:discipline=>"Speech Therapy", :remaining_visits=>40, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"10-03-2023"}])
    end

    it "should correctly parse the pacing for patient 10509" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>79, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"09-28-2023"}])
    end

    it "should correctly parse the pacing for patient 10515" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10516" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>28, :used_visits=>4, :pace=>-25, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>29, :reset_date=>"11-18-2022"}])
    end

    it "should correctly parse the pacing for patient 10517" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10518" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-04-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10519" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-08-2021", :end_date=>"12-08-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10544" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>30, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>46, :used_visits=>14, :pace=>-15, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>29, :reset_date=>"04-22-2023"}])
    end

    it "should correctly parse the pacing for patient 10549" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-04-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10552" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-13-2022", :end_date=>"01-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10575" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10576" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-23-2021", :end_date=>"11-22-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-23-2021", :end_date=>"11-22-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([])
    end

    it "should correctly parse the pacing for patient 10579" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-25-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-25-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10581" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"10-26-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10587" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-11-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10588" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-30-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10589" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-08-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10591" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10592" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10594" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-30-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"05-26-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10597" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-16-2021", :end_date=>"11-15-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10599" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-26-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10600" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-13-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10602" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"08-14-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10604" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-03-2022", :end_date=>"02-02-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10609" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-28-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10611" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"10-29-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10614" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-09-2021", :end_date=>"12-09-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10615" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-12-2022", :end_date=>"10-12-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-12-2022", :end_date=>"10-12-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10628" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10630" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-25-2022", :type_of_service=>"Language Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>52, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>32, :used_visits=>68, :pace=>-30, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>98, :reset_date=>"10-25-2022"}])
    end

    it "should correctly parse the pacing for patient 10634" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"05-24-2023", :type_of_service=>"Language Therapy", :frequency=>80, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>50, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>69, :used_visits=>11, :pace=>-21, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>32, :reset_date=>"05-24-2023"}])
    end

    it "should correctly parse the pacing for patient 10638" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-22-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10639" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10642" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10648" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10649" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10650" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-25-2022", :end_date=>"01-24-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10654" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-15-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10672" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-06-2022", :end_date=>"01-06-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10677" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10681" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-09-2023", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>34, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>57, :used_visits=>13, :pace=>-18, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>31, :reset_date=>"05-09-2023"}])
    end

    it "should correctly parse the pacing for patient 10684" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 10686" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-27-2023", :type_of_service=>"Speech Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>45, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>51, :used_visits=>19, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>33, :reset_date=>"04-27-2023"}])
    end

    it "should correctly parse the pacing for patient 10687" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-26-2022", :end_date=>"09-26-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10690" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-03-2023", :type_of_service=>"Language Therapy", :frequency=>81, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>69, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>41, :used_visits=>50, :pace=>-6, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>56, :reset_date=>"03-03-2023"}])
    end

    it "should correctly parse the pacing for patient 10691" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-27-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10692" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-01-2022", :end_date=>"06-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10693" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10709" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"01-24-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10713" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-22-2021", :end_date=>"10-22-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10717" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-25-2023", :type_of_service=>"Language Therapy", :frequency=>35, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>35, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>34, :used_visits=>11, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>22, :reset_date=>"04-25-2023"}])
    end

    it "should correctly parse the pacing for patient 10719" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-15-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10722" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>34, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>44, :used_visits=>26, :pace=>-21, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>47, :reset_date=>"02-10-2023"}])
    end

    it "should correctly parse the pacing for patient 10724" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10735" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10738" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10743" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10748" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-06-2021", :end_date=>"12-02-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10751" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10752" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-03-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-03-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10754" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-21-2022", :end_date=>"10-29-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10756" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"07-27-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"07-27-2022", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"07-28-2022", :end_date=>"02-02-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"07-28-2022", :end_date=>"02-02-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10759" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-03-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10760" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10766" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>43, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>64, :used_visits=>6, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"09-08-2023"}])
    end

    it "should correctly parse the pacing for patient 10772" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10773" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10774" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-09-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-09-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10776" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10781" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-28-2021", :end_date=>"12-08-2022", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 10782" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-05-2021", :end_date=>"11-05-2022", :type_of_service=>"Speech Therapy", :frequency=>41, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>57, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"11-05-2021", :end_date=>"11-05-2022", :type_of_service=>"Language Therapy", :frequency=>40, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>57, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>26, :used_visits=>65, :pace=>-21, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>86, :reset_date=>"11-05-2022"}])
    end

    it "should correctly parse the pacing for patient 10787" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end
  end
end