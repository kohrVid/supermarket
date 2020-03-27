require 'spec_helper'
require_relative '../../../lib/models/reward_type/percent_off.rb'

RSpec.describe RewardType::PercentOff, type: :model do
  let(:percent_off) do
    FactoryBot.create(:percent_off)
  end

  let(:order) { FactoryBot.create(:order) }
  let(:item_a) { FactoryBot.create(:item, :a) }
  let(:item_b) { FactoryBot.create(:item, :b) }

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
  end
end
