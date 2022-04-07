require 'spec_helper'

# RSpec.describe Pacing do
#     describe '#greet' do
#         it "says hello" do
#             expect(Pacing.new.greet).to eq("Hello, world!")
#         end
#     end
# end

RSpec.describe Pacing::Pacer do
  describe '#new' do
    it "return some data" do
      school_plan = {school_plan_service: [{school_plan_type: 'IEP', start_date: '1-01-22', end_date: '1-01-23', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: '1 per month' }, {school_plan_type: 'IEP', start_date: '1-01-22', end_date: '1-01-23', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: '1 per month' }]}
      date = '22-1-2022'
      non_business_days = ['25-1-2022']
      expect(Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days ).calculate).to eq({school_plan_service: [{school_plan_type: 'IEP', start_date: '1-01-22', end_date: '1-01-23', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sesssions_allowable: 'monthly', remaining_visits: 0, reset_date: '31-01-2022', pace: 4, pace_indicator: "🐇" }, {school_plan_type: 'IEP', start_date: '1-01-22', end_date: '1-01-23', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session_in_minutes: 30, completed_visits_for_current_interval: 7, extra_sessions_allowable: 1, interval_for_extra_sesssions_allowable: 'monthly', remaining_visits: 0, reset_date: '31-01-2022', pace: 4, pace_indicator: "🐇" }]})
    end
  end
end