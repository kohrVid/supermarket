require 'spec_helper'
require_relative "../../lib/models/reward.rb"

RSpec.describe Reward, group: :model do
  it "should be valid if created with the correct attributes" do
    expect(FactoryBot.build(:reward, :percent_off)).to be_valid
  end

  context "#pricing_rule_id" do
    it "should be present" do
      expect(
        FactoryBot.build(:reward, :percent_off, pricing_rule_id: nil)
      ).to_not be_valid
    end
  end

  context "#reward_id" do
    it "should be present" do
      expect(
        FactoryBot.build(:reward, :percent_off, reward_id: nil)
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
    let(:percent_off_reward) { FactoryBot.create(:reward, :percent_off) }
    let(:value_off_reward) { FactoryBot.create(:reward, :value_off) }

    it "should belong to a pricing rule" do
      expect(percent_off_reward).to respond_to(:pricing_rule)
      expect(percent_off_reward.pricing_rule).to be_an_instance_of(PricingRule)
    end

    it "should belong to a reward type" do
      expect(percent_off_reward).to respond_to(:type)
      expect(percent_off_reward.type).to be_an_instance_of(RewardType)
    end

    context "#body" do
      it "should return a percent_off row if the reward is a percent_off type" do
        expect(percent_off_reward.body).to eq(RewardType::PercentOff.last)
      end

      it "should return a value_off row if the reward is a value_off type" do
        expect(value_off_reward.body).to eq(RewardType::ValueOff.last)
      end
    end
  end
end
