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
      iep = {iep_service: [{start_date: '1-01-22', end_date: '1-01-23', type_of_service: 'Language Therapy', frequency: 6, interval: 'monthly', time_per_session: 30, completed_visits_for_current_interval: 7 }, {start_date: '1-01-22', end_date: '1-01-23', type_of_service: 'Physical Therapy', frequency: 6, interval: 'monthly', time_per_session: 30, completed_visits_for_current_interval: 7 }]}
      date = '22-1-2022'
      expect(Pacing::Pacer.new(iep: iep, date: date).calculate).to eq({ "remaining_visits" => 3, "reset_date" => '31-01-2022', "pace" => 4, "pace_indicator" => "🐇"})
    end
  end
end