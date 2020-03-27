require 'spec_helper'
require_relative "../../lib/models/reward_type.rb"

RSpec.describe RewardType, type: :model do
  it "should be valid with the correct attributes" do
    expect(FactoryBot.build(:reward_type, :percent_off)).to be_valid
  end

  context "#name" do
    it "should be present" do
      expect(FactoryBot.build(:reward_type)).to_not be_valid
    end

    it "should be unique" do
      FactoryBot.create(:reward_type, :percent_off)
      expect(FactoryBot.build(:reward_type, :percent_off)).to_not be_valid
    end
  end
end
