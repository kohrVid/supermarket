require 'spec_helper'
require_relative '../../../lib/models/reward_type/percent_off.rb'

RSpec.describe RewardType::PercentOff, type: :model do
  let(:percent_off) do
    FactoryBot.create(:percent_off)
  end

  it "should be valid with the correct attributes" do
    expect(FactoryBot.build(:percent_off)).to be_valid
  end

  context "#percentage" do
    it "should be present" do
      expect(FactoryBot.build(:percent_off, percentage: nil)).to_not be_valid
    end

    it "should be unique" do
      percent_off

      expect(FactoryBot.build(:percent_off)).to_not be_valid
    end

    it "should be less than 100" do
      expect(FactoryBot.build(:percent_off, percentage: 100.0)).to_not be_valid
    end
  end

  context "calculate_deduction" do
    it "should return the correct deduction amount for an amount given" do
      expect(percent_off.calculate_deduction(10000)).to eq(1000)
    end
  end
end
