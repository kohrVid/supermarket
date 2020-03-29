require 'spec_helper'
require_relative '../../../lib/models/reward_type/value_off.rb'

RSpec.describe RewardType::ValueOff, type: :model do
  let(:value_off) do
    FactoryBot.create(:value_off)
  end

  it "should be valid with the correct attributes" do
    expect(FactoryBot.build(:value_off)).to be_valid
  end

  context "#value" do
    it "should be present" do
      expect(FactoryBot.build(:value_off, value: nil)).to_not be_valid
    end

    it "should be unique" do
      value_off

      expect(FactoryBot.build(:value_off)).to_not be_valid
    end
  end

  context "calculate_deduction" do
    it "should return the correct calculate_deduction for a given amount" do
      expect(value_off.calculate_deduction(10000, 1)).to eq(1000)
    end

    it "should allow the caller to apply the calculate_deduction multiple times if specified" do
      expect(value_off.calculate_deduction(10000, 2)).to eq(2000)
    end

    it "should return 0 if the original amount is less than or equal to the calculate_deduction" do
      expect(value_off.calculate_deduction(1000, 2)).to eq(0)
    end
  end
end
