require 'spec_helper'
require_relative "../../../lib/models/item_order.rb"
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

  context "apply" do
    it "should reduce an order total by the correct amount" do
      order.items << [item_a, item_b]
      value_off.apply(order)

      expect(order.total).to eq(7000)
    end

    it "should not reduce an order's subtotal" do
      order.items << [item_a, item_b]
      value_off.apply(order)

      expect(order.subtotal).to eq(8000)
    end
  end
end
