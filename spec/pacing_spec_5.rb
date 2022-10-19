require 'spec_helper'
require 'date'

# update readme for treatment start date
# update readme for state
# update readme for new start date issue
# update code for it

RSpec.describe Pacing::Pacer do
  describe "Cue based specs" do
    it "should correctly parse the pacing for patient 12554" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12555" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12556" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12557" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"05-20-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12558" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"01-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12559" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12560" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech and Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12562" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12563" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-07-2022", :end_date=>"11-08-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"01-07-2022", :end_date=>"11-08-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"01-07-2022", :end_date=>"11-08-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12564" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>12, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>18, :used_visits=>4, :pace=>-8, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>12, :reset_date=>"04-07-2023"}])
    end

    it "should correctly parse the pacing for patient 12566" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12569" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"07-31-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"04-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-27-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12570" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-04-2022", :end_date=>"12-14-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-04-2022", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12571" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12573" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12575" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"11-08-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"11-08-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12578" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-26-2022", :end_date=>"04-26-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12581" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12582" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12583" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12584" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12587" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12588" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-19-2022", :end_date=>"02-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12590" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-04-2022", :end_date=>"08-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12592" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-17-2022", :end_date=>"04-27-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-23-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12593" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"04-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"04-07-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12594" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Physical Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12595" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-10-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12596" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12597" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12598" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12599" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12600" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"01-13-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"01-13-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12601" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-21-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12602" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12604" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12605" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12606" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12607" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12608" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"02-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-24-2022", :end_date=>"02-24-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12610" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"03-21-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"03-21-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12611" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-20-2022", :end_date=>"07-31-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-20-2022", :end_date=>"07-31-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-20-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-20-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12612" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12614" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-26-2022", :end_date=>"02-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-26-2022", :end_date=>"02-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12615" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-20-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12616" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-25-2022", :end_date=>"02-25-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12617" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>0, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12618" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12619" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"03-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"03-03-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12621" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-06-2022", :end_date=>"04-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12622" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"10-18-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12623" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"03-03-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"03-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12624" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-11-2022", :end_date=>"10-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-11-2022", :end_date=>"10-11-2023", :type_of_service=>"Physical Therapy", :frequency=>10, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>16, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>9, :used_visits=>1, :pace=>1, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-11-2023"}])
    end

    it "should correctly parse the pacing for patient 12629" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12630" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12636" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"11-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"11-30-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12637" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12638" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12639" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-06-2022", :end_date=>"03-01-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-06-2022", :end_date=>"03-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12640" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12641" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12643" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12644" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12645" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12646" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12647" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12648" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-16-2022", :end_date=>"06-16-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12649" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12653" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"07-31-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-11-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"07-31-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-11-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12654" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-02-2022", :end_date=>"11-17-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12655" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"07-31-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"07-31-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-16-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-16-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>5, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12656" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"08-02-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-02-2022", :end_date=>"05-16-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12659" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12660" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12661" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-15-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-15-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12662" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"06-20-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"06-20-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"06-20-2023", :type_of_service=>"Speech and Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12663" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-15-2022", :end_date=>"06-15-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12671" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12672" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12673" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"03-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12675" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-10-2022", :end_date=>"03-10-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12677" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12679" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12680" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-15-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12681" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12682" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12683" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Physical Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12684" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12685" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-02-2022", :end_date=>"02-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-02-2022", :end_date=>"02-24-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-02-2022", :end_date=>"02-24-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12686" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12688" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>13, :used_visits=>1, :pace=>-12, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>13, :reset_date=>"11-19-2022"}])
    end

    it "should correctly parse the pacing for patient 12689" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12690" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12691" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12692" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12693" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12695" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12696" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-28-2022", :end_date=>"01-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12697" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-23-2021", :end_date=>"11-23-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-23-2021", :end_date=>"11-23-2022", :type_of_service=>"Physical Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12698" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-02-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12699" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12700" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12701" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"02-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12702" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-26-2022", :end_date=>"03-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12705" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12706" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"05-20-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"03-29-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12707" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"04-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12708" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"07-28-2022", :end_date=>"04-06-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"07-28-2022", :end_date=>"04-06-2023", :type_of_service=>"Physical Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"07-28-2022", :end_date=>"04-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12709" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-04-2021", :end_date=>"11-04-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-04-2021", :end_date=>"11-04-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12710" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"02-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12711" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Physical Therapy", :frequency=>15, :interval=>"yearly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>39, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>23, :used_visits=>2, :pace=>1, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"09-30-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12712" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-05-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-05-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12713" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12715" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12716" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-29-2022", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12717" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12718" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-28-2022", :end_date=>"01-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12719" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"08-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12720" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"07-31-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"10-27-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12721" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"10-28-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"10-28-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12722" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"06-22-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"06-22-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"06-22-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"06-22-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>6, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12726" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-09-2021", :end_date=>"11-09-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12727" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12728" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12729" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"01-12-2022", :end_date=>"01-12-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12730" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"11-19-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"11-19-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"11-19-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12731" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12732" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12733" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>3, :pace=>1, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12734" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12735" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-15-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12736" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12737" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12738" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-15-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12739" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-14-2022", :end_date=>"02-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-14-2022", :end_date=>"02-14-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12740" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-12-2022", :end_date=>"10-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-12-2022", :end_date=>"10-19-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12741" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"03-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"03-03-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12742" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12744" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"11-29-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"11-29-2022", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12746" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-18-2021", :end_date=>"10-18-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12747" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12748" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"08-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"08-12-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"08-12-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12750" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-28-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-28-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12751" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"08-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12752" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-31-2022", :end_date=>"01-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12755" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"11-05-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12756" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12757" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12758" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-26-2022", :end_date=>"01-26-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12759" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12760" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12761" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12763" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-15-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-15-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-15-2021", :end_date=>"11-15-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12764" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"06-24-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"01-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12765" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"12-02-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12766" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12769" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12770" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12787" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-18-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12790" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12805" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"03-18-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12825" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12826" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12827" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12828" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"01-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12829" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-28-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12831" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12832" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12833" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12834" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12835" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-21-2022", :end_date=>"01-21-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12836" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"11-16-2022", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"11-16-2022", :type_of_service=>"Physical Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12837" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-13-2022", :end_date=>"10-13-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-13-2022", :end_date=>"10-13-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"10-13-2022", :end_date=>"10-13-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12838" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"03-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"03-09-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"03-09-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12839" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12840" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12841" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12842" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"12-07-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"12-07-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"12-07-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12843" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12844" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12845" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"04-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"04-04-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"04-04-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12846" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-20-2021", :end_date=>"10-20-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12847" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12848" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"03-30-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12849" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-02-2022", :end_date=>"04-20-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-02-2022", :end_date=>"04-20-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12850" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-18-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12851" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-16-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12852" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-08-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-09-2022", :end_date=>"03-08-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12853" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-07-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12854" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-17-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12855" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"07-01-2022", :end_date=>"04-18-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"07-01-2022", :end_date=>"04-18-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12859" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-13-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-13-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12860" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12861" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"12-07-2022", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12863" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-17-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>9, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12866" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-28-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"yearly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"03-28-2023"}])
    end

    it "should correctly parse the pacing for patient 12867" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"04-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12869" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12870" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-17-2022", :end_date=>"02-17-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12871" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12872" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12873" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-17-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-17-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12874" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-11-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12876" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-11-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-11-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12878" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12880" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-21-2022", :end_date=>"12-13-2022", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12881" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"01-10-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"01-10-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"01-10-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12882" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"07-31-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-13-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12883" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12884" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"01-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12885" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-23-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12886" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-24-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12887" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-18-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12888" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12889" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12890" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"12-06-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12891" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12898" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"03-30-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"03-30-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12899" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-26-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-26-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12900" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12901" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"10-25-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12902" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"05-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12903" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"04-19-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"04-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"04-19-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12904" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-04-2022", :end_date=>"06-23-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12905" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12907" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-04-2022", :end_date=>"05-24-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12908" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12909" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12910" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12911" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12912" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-02-2022", :end_date=>"03-03-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-02-2022", :end_date=>"03-03-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12913" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12914" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-20-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12915" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-17-2021", :end_date=>"11-17-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12916" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12917" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-13-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12918" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-03-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12919" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12920" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12921" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12922" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12923" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"08-16-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12924" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12925" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-06-2022", :end_date=>"04-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12926" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"11-17-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12927" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"11-17-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12928" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-03-2022", :end_date=>"02-03-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12929" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12930" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12931" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-21-2022", :end_date=>"01-20-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"01-21-2022", :end_date=>"01-20-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12932" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12934" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12935" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-21-2022", :end_date=>"02-21-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12936" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12937" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12938" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-23-2022", :end_date=>"02-15-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12939" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-17-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12940" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12941" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"05-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12942" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-06-2022", :end_date=>"05-05-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12943" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12944" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12945" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12946" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"05-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12947" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12948" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"05-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12949" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12950" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-17-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12951" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12953" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12954" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-04-2022", :end_date=>"03-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12955" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-03-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12956" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"12-01-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>45, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-10-2022", :end_date=>"12-01-2022", :type_of_service=>"Physical Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>45, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12957" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12958" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"10-28-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>40, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"10-28-2022", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>40, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12959" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12960" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"07-25-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"07-25-2023", :type_of_service=>"Occupation Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12961" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12962" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12963" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-25-2022", :end_date=>"02-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-25-2022", :end_date=>"02-24-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12964" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"11-29-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12965" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>0, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12966" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-20-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12967" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-19-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12968" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-28-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12970" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"07-19-2022", :end_date=>"07-15-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>14, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>56, :used_visits=>14, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>18, :reset_date=>"07-15-2023"}])
    end

    it "should correctly parse the pacing for patient 12971" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12974" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-14-2022", :end_date=>"01-14-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12975" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-19-2021", :end_date=>"11-19-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12976" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12977" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"08-12-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"08-12-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12978" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"03-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"03-01-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12979" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-08-2022", :end_date=>"03-08-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12980" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-17-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-17-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-17-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12981" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"08-15-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12982" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"05-18-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12983" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-30-2023", :type_of_service=>"Physical Therapy", :frequency=>15, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>15, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"09-30-2023"}])
    end

    it "should correctly parse the pacing for patient 12984" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12986" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12988" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"01-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"01-24-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12989" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12990" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12991" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-21-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-21-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12992" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12993" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-19-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12994" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12995" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-13-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12996" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12997" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-30-2022", :end_date=>"03-30-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 12998" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-17-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 12999" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"06-23-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"06-23-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13001" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"07-01-2022", :end_date=>"05-06-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13002" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13003" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"07-01-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"07-01-2022", :end_date=>"04-22-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13004" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13005" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13006" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-20-2022", :end_date=>"04-20-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13007" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-25-2022", :end_date=>"04-25-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13008" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"04-04-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13010" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-18-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13011" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-03-2021", :end_date=>"11-03-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13014" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13015" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-02-2022", :end_date=>"04-05-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13016" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13017" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13018" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13020" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-19-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13021" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13022" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-18-2021", :end_date=>"10-18-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13023" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-01-2021", :end_date=>"12-01-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13024" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-09-2022", :end_date=>"05-23-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-09-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13026" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-26-2022", :end_date=>"09-26-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13027" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-21-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13028" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13029" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-31-2022", :end_date=>"03-30-2023", :type_of_service=>"Speech Therapy", :frequency=>90, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>15, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>75, :used_visits=>15, :pace=>-34, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>49, :reset_date=>"03-30-2023"}])
    end

    it "should correctly parse the pacing for patient 13030" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13032" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"03-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13035" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"11-02-2022", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>1, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13036" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13037" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-02-2021", :end_date=>"12-02-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13038" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13039" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"07-11-2022", :end_date=>"05-13-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>12, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>68, :used_visits=>12, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>26, :reset_date=>"05-13-2023"}])
    end

    it "should correctly parse the pacing for patient 13040" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13042" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-14-2021", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13044" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"01-25-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"01-25-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13045" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"10-22-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"10-22-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13047" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"05-16-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13048" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"03-29-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13049" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"01-13-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13050" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-24-2022", :end_date=>"03-24-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13053" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"11-30-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"11-30-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"11-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13054" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13055" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"01-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"01-05-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13056" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"01-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"01-05-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13057" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-02-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-02-2022", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13058" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13059" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-04-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13060" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"02-17-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13061" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13062" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13063" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-13-2022", :end_date=>"01-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13064" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"03-16-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"03-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"03-16-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13065" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"12-16-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13067" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13069" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>3, :pace=>1, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13070" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-24-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13071" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-18-2023", :type_of_service=>"Occupation Therapy", :frequency=>10, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"02-18-2023"}])
    end

    it "should correctly parse the pacing for patient 13072" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"05-11-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13073" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13074" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13075" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"12-16-2022", :type_of_service=>"Speech Therapy", :frequency=>16, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>16, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>16, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>19, :reset_date=>"12-16-2022"}])
    end

    it "should correctly parse the pacing for patient 13076" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-08-2022", :end_date=>"04-08-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13079" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Speech Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>11, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>21, :used_visits=>11, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>17, :reset_date=>"04-05-2023"}])
    end

    it "should correctly parse the pacing for patient 13080" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-11-2022", :end_date=>"02-11-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13081" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"05-23-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"05-23-2022", :end_date=>"05-23-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13082" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"04-28-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13083" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-22-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-22-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13084" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13085" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13087" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13088" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-18-2022", :end_date=>"08-18-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-18-2022", :end_date=>"08-18-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-18-2022", :end_date=>"08-18-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13089" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-11-2022", :end_date=>"08-10-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13091" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-14-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>3, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13092" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-07-2022", :end_date=>"02-07-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13094" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-08-2022", :end_date=>"02-08-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13095" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13096" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-11-2022", :end_date=>"05-11-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13097" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>23, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>100, :used_visits=>8, :pace=>1, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"09-22-2023"}])
    end

    it "should correctly parse the pacing for patient 13098" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"08-31-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"08-31-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"08-31-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13099" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"07-12-2022", :end_date=>"06-21-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13100" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13101" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"11-10-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13102" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-19-2022", :end_date=>"01-26-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13105" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-16-2021", :end_date=>"12-16-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13106" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-21-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13107" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-12-2021", :end_date=>"11-12-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13109" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-04-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-04-2022", :end_date=>"05-19-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13110" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Speech Therapy", :frequency=>10, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13111" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"08-14-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13113" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-23-2022", :end_date=>"08-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13114" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-08-2022", :end_date=>"03-10-2023", :type_of_service=>"Language Therapy", :frequency=>62, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>58, :used_visits=>4, :pace=>-16, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>20, :reset_date=>"03-10-2023"}])
    end

    it "should correctly parse the pacing for patient 13119" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-28-2022", :end_date=>"03-28-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13120" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-16-2022", :end_date=>"08-16-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>1, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13121" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13122" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13123" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13124" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"07-25-2022", :end_date=>"06-28-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13125" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"05-24-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13126" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13128" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13129" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13131" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-18-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13132" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-26-2022", :end_date=>"09-26-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-26-2022", :end_date=>"09-26-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13134" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>10, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13136" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-20-2022", :end_date=>"06-20-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>3, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13137" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-22-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13138" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-11-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-11-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13139" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-11-2022", :end_date=>"04-11-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"04-11-2023"}])
    end

    it "should correctly parse the pacing for patient 13140" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13141" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13142" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13144" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13145" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-20-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"10-21-2021", :end_date=>"10-20-2022", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13147" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-21-2022", :end_date=>"03-22-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13148" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-03-2021", :end_date=>"12-03-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13149" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13150" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13153" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-02-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-02-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13154" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-03-2022", :end_date=>"12-17-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"02-03-2022", :end_date=>"12-17-2022", :type_of_service=>"Occupation Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13155" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-12-2022", :end_date=>"08-12-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13156" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-08-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13157" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-15-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13158" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-18-2023", :type_of_service=>"Physical Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-18-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"04-18-2023", :type_of_service=>"Occupation Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13161" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-26-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13163" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-29-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>25, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"04-29-2023", :type_of_service=>"Physical Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13164" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-29-2022", :end_date=>"09-29-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13165" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13169" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-06-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13170" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-22-2022", :end_date=>"03-22-2023", :type_of_service=>"Language Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>28, :used_visits=>4, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>18, :reset_date=>"03-22-2023"}])
    end

    it "should correctly parse the pacing for patient 13171" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"08-14-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>2, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13172" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-15-2022", :end_date=>"08-14-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13173" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"07-10-2022", :end_date=>"07-10-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>78, :used_visits=>2, :pace=>-20, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>22, :reset_date=>"07-10-2023"}])
    end

    it "should correctly parse the pacing for patient 13174" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13175" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13177" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13178" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-03-2022", :end_date=>"05-03-2023", :type_of_service=>"Language Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>8, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>24, :used_visits=>8, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>15, :reset_date=>"05-03-2023"}])
    end

    it "should correctly parse the pacing for patient 13180" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-01-2022", :end_date=>"03-01-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13185" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"11-09-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"11-09-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13187" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13188" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-11-2021", :end_date=>"11-11-2022", :type_of_service=>"Speech Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>20, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>22, :used_visits=>20, :pace=>-19, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>39, :reset_date=>"11-11-2022"}])
    end

    it "should correctly parse the pacing for patient 13189" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13190" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-17-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-17-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13191" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-09-2022", :end_date=>"08-09-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13192" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-02-2022", :end_date=>"11-16-2022", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13193" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"07-01-2022", :end_date=>"04-18-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"07-01-2022", :end_date=>"04-18-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13194" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-10-2022", :end_date=>"08-09-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-10-2022", :end_date=>"08-09-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>3, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13195" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Language Therapy", :frequency=>31, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>41, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-05-2023"}])
    end

    it "should correctly parse the pacing for patient 13198" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-04-2021", :end_date=>"11-04-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13199" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13200" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-05-2022", :end_date=>"01-05-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13201" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"04-27-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13202" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13203" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"05-03-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"05-03-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13204" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"09-06-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13205" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"03-22-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13206" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13207" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"02-09-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"02-09-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13208" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-04-2022", :end_date=>"05-18-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13209" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-24-2022", :end_date=>"08-24-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13211" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>9, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13212" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>9, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13214" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-07-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13218" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-29-2022", :end_date=>"04-29-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13219" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13220" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"05-24-2023", :type_of_service=>"Language Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>9, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>23, :used_visits=>9, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>13, :reset_date=>"05-24-2023"}])
    end

    it "should correctly parse the pacing for patient 13222" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-28-2021", :end_date=>"10-28-2022", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13225" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Language Therapy", :frequency=>31, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"08-22-2023", :type_of_service=>"Speech Therapy", :frequency=>31, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>65, :used_visits=>7, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>11, :reset_date=>"08-22-2023"}])
    end

    it "should correctly parse the pacing for patient 13227" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-30-2021", :end_date=>"11-30-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13228" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"05-24-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-24-2022", :end_date=>"05-24-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13229" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"03-16-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"03-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>0, :used_visits=>1, :pace=>0, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13230" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-07-2022", :end_date=>"04-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13231" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-26-2021", :end_date=>"10-26-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13232" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"08-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13233" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"06-23-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13235" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"03-10-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13236" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-24-2022", :end_date=>"12-17-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13238" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>69, :used_visits=>1, :pace=>-9, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>10, :reset_date=>"08-25-2023"}])
    end

    it "should correctly parse the pacing for patient 13240" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-15-2022", :end_date=>"02-14-2023", :type_of_service=>"Language Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>37, :used_visits=>3, :pace=>-24, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>27, :reset_date=>"02-14-2023"}])
    end

    it "should correctly parse the pacing for patient 13241" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-18-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"08-18-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13243" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-21-2022", :end_date=>"01-21-2023", :type_of_service=>"Speech Therapy", :frequency=>20, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>19, :used_visits=>1, :pace=>-14, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>15, :reset_date=>"01-21-2023"}])
    end

    it "should correctly parse the pacing for patient 13244" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-19-2022", :end_date=>"01-19-2023", :type_of_service=>"Speech Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>35, :used_visits=>7, :pace=>-24, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>31, :reset_date=>"01-19-2023"}])
    end

    it "should correctly parse the pacing for patient 13249" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-12-2022", :end_date=>"10-12-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13251" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13252" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>45, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"monthly", :time_per_session_in_minutes=>45, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13253" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Physical Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>9, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>70, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"09-28-2023"}])
    end

    it "should correctly parse the pacing for patient 13254" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"10-10-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"10-11-2022", :end_date=>"01-31-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13258" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-08-2021", :end_date=>"11-08-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13259" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13260" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13261" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>3, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13262" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13263" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"08-25-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13264" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-22-2021", :end_date=>"10-21-2022", :type_of_service=>"Language Therapy", :frequency=>0, :interval=>"monthly", :time_per_session_in_minutes=>70, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>0, :used_visits=>1, :pace=>1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13266" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-03-2022", :end_date=>"03-30-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13267" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-14-2022", :end_date=>"04-14-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13268" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"12-14-2022", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-22-2022", :end_date=>"12-14-2022", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13270" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-18-2022", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13271" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"12-01-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13272" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"04-18-2023", :type_of_service=>"Speech and Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13273" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-13-2022", :end_date=>"04-13-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13274" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-31-2022", :end_date=>"08-31-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13277" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-22-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-22-2022", :end_date=>"02-22-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13278" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-04-2022", :end_date=>"05-04-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13280" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-19-2022", :end_date=>"06-22-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13281" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-09-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13282" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"07-31-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"11-16-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13284" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-16-2022", :end_date=>"02-16-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13285" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-17-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13286" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13287" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Physical Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>29, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"09-28-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13289" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-08-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13290" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-02-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-02-2022", :end_date=>"02-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13292" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"08-29-2023", :type_of_service=>"Physical Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13294" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-16-2022", :end_date=>"08-01-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"05-16-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13295" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-02-2021", :end_date=>"11-02-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13296" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-23-2022", :end_date=>"02-23-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13297" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-02-2022", :end_date=>"03-02-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13298" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13299" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-05-2022", :end_date=>"04-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13300" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-18-2022", :end_date=>"08-18-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13301" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13302" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-09-2023", :type_of_service=>"Physical Therapy", :frequency=>5, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"02-09-2022", :end_date=>"02-09-2023", :type_of_service=>"Occupation Therapy", :frequency=>10, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>7, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>0, :used_visits=>5, :pace=>2, :pace_indicator=>"🐇", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"02-09-2023"}, {:discipline=>"Occupational Therapy", :remaining_visits=>8, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"02-09-2023"}])
    end

    it "should correctly parse the pacing for patient 13303" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-10-2021", :end_date=>"11-10-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13304" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-01-2022", :end_date=>"09-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13305" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-18-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13308" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-27-2022", :end_date=>"01-27-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13310" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-09-2022", :end_date=>"08-09-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13312" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-15-2022", :end_date=>"03-15-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>9, :used_visits=>4, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13314" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-10-2022", :end_date=>"03-23-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"10-10-2022", :end_date=>"03-22-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13315" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"11-10-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-02-2022", :end_date=>"11-10-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13316" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"09-28-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13317" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13318" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-18-2021", :end_date=>"11-18-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13320" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-10-2022", :end_date=>"05-10-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13323" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-12-2022", :end_date=>"05-12-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13324" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"03-22-2023", :type_of_service=>"Language Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-28-2022", :end_date=>"03-22-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>4, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13325" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-04-2022", :end_date=>"02-04-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13326" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-17-2022", :end_date=>"08-17-2023", :type_of_service=>"Speech Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13328" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"09-15-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>10, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>100, :used_visits=>8, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>9, :reset_date=>"09-15-2023"}])
    end

    it "should correctly parse the pacing for patient 13329" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-06-2022", :end_date=>"04-06-2023", :type_of_service=>"Language Therapy", :frequency=>31, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>40, :used_visits=>1, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>12, :reset_date=>"04-06-2023"}])
    end

    it "should correctly parse the pacing for patient 13332" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-05-2022", :end_date=>"11-17-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>2, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13334" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-13-2021", :end_date=>"12-13-2022", :type_of_service=>"Speech Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>10, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>32, :used_visits=>10, :pace=>-25, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>35, :reset_date=>"12-13-2022"}])
    end

    it "should correctly parse the pacing for patient 13335" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-18-2022", :end_date=>"11-09-2022", :type_of_service=>"Speech Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>31, :used_visits=>1, :pace=>-27, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>28, :reset_date=>"11-09-2022"}])
    end

    it "should correctly parse the pacing for patient 13337" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>8, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>100, :used_visits=>8, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>10, :reset_date=>"09-14-2023"}])
    end

    it "should correctly parse the pacing for patient 13338" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-12-2022", :end_date=>"10-12-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"10-12-2022", :end_date=>"10-12-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"10-12-2022", :end_date=>"10-12-2023", :type_of_service=>"Physical Therapy", :frequency=>30, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Physical Therapy", :remaining_visits=>40, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-12-2023"}])
    end

    it "should correctly parse the pacing for patient 13339" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-19-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13341" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"09-07-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13342" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-20-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13343" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13344" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13345" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-06-2022", :end_date=>"04-06-2023", :type_of_service=>"Speech Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>41, :used_visits=>1, :pace=>-21, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>22, :reset_date=>"04-06-2023"}])
    end

    it "should correctly parse the pacing for patient 13346" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-20-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-20-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>2, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13348" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-01-2022", :end_date=>"01-05-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13349" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-26-2022", :end_date=>"09-26-2023", :type_of_service=>"Language Therapy", :frequency=>31, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>31, :used_visits=>0, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"09-26-2023"}])
    end

    it "should correctly parse the pacing for patient 13351" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-07-2022", :end_date=>"05-02-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13352" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"11-07-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13354" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"09-20-2023", :type_of_service=>"Speech Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>68, :used_visits=>2, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"09-20-2023"}])
    end

    it "should correctly parse the pacing for patient 13355" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-10-2022", :end_date=>"01-10-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13356" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-03-2022", :end_date=>"12-13-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>1, :pace=>0, :pace_indicator=>"😁", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13357" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-27-2022", :end_date=>"04-26-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13358" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-13-2022", :end_date=>"01-13-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13359" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-28-2022", :end_date=>"04-28-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13360" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-11-2021", :end_date=>"11-11-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"11-11-2021", :end_date=>"11-11-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13363" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"03-29-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"03-29-2022", :end_date=>"03-29-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13364" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-05-2022", :end_date=>"05-05-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13365" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-15-2021", :end_date=>"12-15-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13367" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"03-17-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-04-2022", :end_date=>"03-17-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13369" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-25-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13371" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-14-2022", :end_date=>"02-10-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13374" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>5, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>5, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13375" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-05-2022", :end_date=>"10-05-2023", :type_of_service=>"Speech Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>107, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"10-05-2023"}])
    end

    it "should correctly parse the pacing for patient 13376" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"11-30-2022", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13377" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-02-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>11, :used_visits=>2, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13379" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-22-2022", :end_date=>"04-22-2023", :type_of_service=>"Speech Therapy", :frequency=>32, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>8, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>24, :used_visits=>8, :pace=>-8, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>16, :reset_date=>"04-22-2023"}])
    end

    it "should correctly parse the pacing for patient 13382" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"04-12-2022", :end_date=>"04-12-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13385" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"08-25-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13387" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-11-2022", :end_date=>"08-29-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-29-2022", :end_date=>"03-11-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>10, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13392" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Occupation Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>15, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13393" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-30-2022", :end_date=>"08-30-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13396" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-12-2022", :end_date=>"09-12-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13402" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"12-07-2021", :end_date=>"12-07-2022", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13404" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-01-2021", :end_date=>"11-01-2022", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>4, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13406" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-08-2022", :end_date=>"09-08-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13408" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"11-29-2021", :end_date=>"11-28-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13409" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-09-2022", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13410" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"04-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"05-13-2022", :end_date=>"04-07-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13411" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-06-2022", :end_date=>"04-07-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>3, :used_visits=>1, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>2, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13414" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-16-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13423" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"03-17-2022", :end_date=>"03-17-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13427" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-17-2022", :end_date=>"05-17-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>6, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13430" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-02-2022", :end_date=>"09-01-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13432" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"01-11-2022", :end_date=>"01-11-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13439" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13444" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-14-2022", :end_date=>"09-14-2023", :type_of_service=>"Language Therapy", :frequency=>108, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>118, :used_visits=>0, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>11, :reset_date=>"09-14-2023"}])
    end

    it "should correctly parse the pacing for patient 13446" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-15-2022", :end_date=>"04-28-2023", :type_of_service=>"Language Therapy", :frequency=>31, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([])
    end

    it "should correctly parse the pacing for patient 13447" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([])
    end

    it "should correctly parse the pacing for patient 13450" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-13-2022", :end_date=>"09-13-2023", :type_of_service=>"Speech Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([])
    end

    it "should correctly parse the pacing for patient 13451" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-16-2022", :end_date=>"09-15-2023", :type_of_service=>"Language Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13456" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Language Therapy", :frequency=>35, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"08-26-2022", :end_date=>"08-26-2023", :type_of_service=>"Speech Therapy", :frequency=>35, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>80, :used_visits=>0, :pace=>-11, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>11, :reset_date=>"08-26-2023"}])
    end

    it "should correctly parse the pacing for patient 13458" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-09-2022", :end_date=>"09-08-2022", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([])
    end

    it "should correctly parse the pacing for patient 13459" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"08-09-2022", :end_date=>"08-08-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"08-09-2022", :end_date=>"08-08-2023", :type_of_service=>"Speech Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13460" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>13, :used_visits=>0, :pace=>-7, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>7, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13461" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"06-02-2022", :end_date=>"05-26-2023", :type_of_service=>"Speech Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"06-02-2022", :end_date=>"05-26-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>0, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13462" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Language Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}, {:school_plan_type=>"IEP", :start_date=>"10-03-2022", :end_date=>"10-03-2023", :type_of_service=>"Speech Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>1, :pace=>-3, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13464" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"04-29-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13468" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-18-2022", :end_date=>"09-06-2023", :type_of_service=>"Language Therapy", :frequency=>8, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>1, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13469" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-19-2022", :end_date=>"09-06-2023", :type_of_service=>"Language Therapy", :frequency=>2, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>2, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13470" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-23-2022", :end_date=>"09-23-2023", :type_of_service=>"Language Therapy", :frequency=>70, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>80, :used_visits=>0, :pace=>-5, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>5, :reset_date=>"09-23-2023"}])
    end

    it "should correctly parse the pacing for patient 13471" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"12-10-2021", :end_date=>"12-10-2022", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>5, :used_visits=>1, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>3, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13472" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-01-2022", :end_date=>"02-01-2023", :type_of_service=>"Speech Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([])
    end

    it "should correctly parse the pacing for patient 13475" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"12-07-2022", :type_of_service=>"Language Therapy", :frequency=>60, :interval=>"yearly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"yearly"}, {:school_plan_type=>"IEP", :start_date=>"09-20-2022", :end_date=>"12-07-2022", :type_of_service=>"Occupation Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>3, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>67, :used_visits=>3, :pace=>-22, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>25, :reset_date=>"12-07-2022"}, {:discipline=>"Occupational Therapy", :remaining_visits=>7, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13478" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-27-2022", :end_date=>"09-27-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>4, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>8, :used_visits=>4, :pace=>-2, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13479" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-07-2022", :end_date=>"05-13-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>2, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>10, :used_visits=>2, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13481" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"05-19-2022", :end_date=>"05-19-2023", :type_of_service=>"Language Therapy", :frequency=>6, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>1, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>7, :used_visits=>0, :pace=>-4, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>4, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13483" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-22-2022", :end_date=>"09-22-2023", :type_of_service=>"Language Therapy", :frequency=>3, :interval=>"weekly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>3, :used_visits=>0, :pace=>-1, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>1, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13487" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-21-2022", :end_date=>"09-21-2023", :type_of_service=>"Speech Therapy", :frequency=>12, :interval=>"monthly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>12, :used_visits=>0, :pace=>-6, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>6, :reset_date=>"11-01-2022"}])
    end

    it "should correctly parse the pacing for patient 13500" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-17-2023", :type_of_service=>"Occupation Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}, {:school_plan_type=>"IEP", :start_date=>"02-18-2022", :end_date=>"02-17-2023", :type_of_service=>"Physical Therapy", :frequency=>1, :interval=>"weekly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"weekly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Occupational Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}, {:discipline=>"Physical Therapy", :remaining_visits=>1, :used_visits=>0, :pace=>0, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>0, :reset_date=>"10-24-2022"}])
    end

    it "should correctly parse the pacing for patient 13505" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"09-30-2022", :end_date=>"09-01-2023", :type_of_service=>"Occupation Therapy", :frequency=>4, :interval=>"monthly", :time_per_session_in_minutes=>30, :completed_visits_for_current_interval=>1, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"monthly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([])
    end

    it "should correctly parse the pacing for patient 13534" do
      school_plan = {:school_plan_services=>[{:school_plan_type=>"IEP", :start_date=>"10-19-2021", :end_date=>"10-19-2022", :type_of_service=>"Speech Therapy", :frequency=>55, :interval=>"yearly", :time_per_session_in_minutes=>20, :completed_visits_for_current_interval=>0, :extra_sessions_allowable=>0, :interval_for_extra_sessions_allowable=>"yearly"}]}
      date = "10-17-2022"
      non_business_days = []
      results = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days)
      expect(results).to eq([{:discipline=>"Speech Therapy", :remaining_visits=>55, :used_visits=>0, :pace=>-55, :pace_indicator=>"🐢", :pace_suggestion=>"once a day", :expected_visits_at_date=>55, :reset_date=>"10-19-2022"}])
    end
  end
end
