require 'spec_helper'
require_relative "../../lib/models/reward.rb"

RSpec.describe Reward, group: :model do
  context "#reward_id" do
    it "should be present" do
      expect(
        FactoryBot.build(:reward)
      ).to_not be_valid
    end
  end

  context "#reward_type_id" do
    it "should be present" do
      expect(
        FactoryBot.build(:reward, :percent_off, reward_type_id: nil)
      ).to_not be_valid
    end
  end

  context "associations" do
    let(:reward) { FactoryBot.create(:reward, :percent_off) }

    it "should belong to a reward type" do
      expect(reward).to respond_to(:type)
    end
  end
end
