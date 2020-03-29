require 'spec_helper'
require_relative '../../../lib/models/item_order.rb'
require_relative '../../../lib/models/restriction_type/minimum_order_value.rb'

RSpec.describe RestrictionType::MinimumOrderValue, type: :model do
  let(:minimum_order_value) do
    FactoryBot.create(:minimum_order_value)
  end

  let(:order) { FactoryBot.create(:order) }
  let(:item) { FactoryBot.create(:item, :a) }

  it "should be unique" do
    minimum_order_value

    expect(FactoryBot.build(:minimum_order_value)).to_not be_valid
  end

  context "#value" do
    it "should be present" do
      expect(
        FactoryBot.build(
          :minimum_order_value,
          value: nil
        )
      ).to_not be_valid
    end

    it "should be above 0" do
      expect(
        FactoryBot.build(
          :minimum_order_value,
          value: 0
        )
      ).to_not be_valid
    end
  end

  context "#check" do
    it "should return a true if an order matches the restriction" do
      order.items << [item, item, item, item]

      expect(minimum_order_value.check(order)).to eq [true, 1]
    end

    it "should return the number of times an order matches the restriction" do
      order.items << [item, item, item, item, item, item, item, item]

      expect(minimum_order_value.check(order)).to eq [true, 2]
    end

    it "should return a false if an order doesn't match the restriction" do
      order.items << [item, item]

      expect(minimum_order_value.check(order)).to eq [false, 0]
    end

    it "should return a false if an order's subtotal is nil" do
      order.total = nil
      expect(minimum_order_value.check(order)).to eq [false, 0]
    end
  end
end
