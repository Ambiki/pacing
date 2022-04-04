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
      iep_interval = 12
      date = '22-1-2022'
      duration = 20
      completed_visits = 14
      expect(Pacing::Pacer.new(iep_interval: iep_interval, date: date, duration: duration, completed_visits: completed_visits).calculate).to eq({ "remaining_visits" => 3, "reset_date" => '31-01-2022', "pace" => 4, "pace_indicator" => "🐇"})
    end
  end
end