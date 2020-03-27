require 'spec_helper'
require_relative '../../../lib/models/reward_type/value_off.rb'

RSpec.describe RewardType::ValueOff, type: :model do
  let(:value_off) do
    FactoryBot.create(:value_off)
  end

  let(:order) { FactoryBot.create(:order) }
  let(:item_a) { FactoryBot.create(:item, :a) }
  let(:item_b) { FactoryBot.create(:item, :b) }

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
end
