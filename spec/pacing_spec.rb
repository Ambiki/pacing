require 'spec_helper'

RSpec.describe Pacing do
    describe '#greet' do
        it "says hello" do
            expect(Pacing.new.greet).to eq("Hello, world!")
        end
    end
end