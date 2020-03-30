require 'spec_helper'
require_relative '../../../lib/models/restriction_type/minimum_item_quantity.rb'

RSpec.describe RestrictionType::MinimumItemQuantity, type: :model do
  let(:minimum_item_quantity) do
    FactoryBot.create(:minimum_item_quantity, :two_of_a)
  end

  let(:order) { FactoryBot.create(:order) }
  let(:item_a) { FactoryBot.create(:item, :a) }
  let(:item_b) { FactoryBot.create(:item, :b) }

  it "should be unique" do
    minimum_item_quantity

    expect(
      FactoryBot.build(
        :minimum_item_quantity,
        :two_of_a,
      )
    ).to_not be_valid
  end

  context "#check" do
    it "should return a true if an order matches the restriction" do
      order.items << [item_a, item_a]

      expect(minimum_item_quantity.check(order)).to eq [true, 1]
    end

    it "should return the number of times an order matches the restriction" do
      order.items << [item_a, item_a, item_a, item_a]

      expect(minimum_item_quantity.check(order)).to eq [true, 2]
    end

    it "should return a false if an order doesn't match the restriction" do
      order.items << [item_a, item_b]

      expect(minimum_item_quantity.check(order)).to eq [false, 0]
    end

    it "should return a false if an order has no items" do
      order.subtotal = nil
      order.items = []

      expect(minimum_item_quantity.check(order)).to eq [false, 0]
    end
  end

  context "#item" do
    it "should belong to an item" do
      expect(minimum_item_quantity).to respond_to(:item)
    end
  end

  context "#item_id" do
    it "should be present" do
      expect(
        FactoryBot.build(
          :minimum_item_quantity,
          :two_of_a,
          item_id: nil
        )
      ).to_not be_valid
    end
  end

  context "#quantity" do
    it "should be above 0" do
      expect(
        FactoryBot.build(
          :minimum_item_quantity,
          :two_of_a,
          quantity: 0
        )
      ).to_not be_valid
    end
  end
end
