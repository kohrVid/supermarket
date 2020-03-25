require 'spec_helper'
require_relative '../../lib/models/order.rb'
require_relative '../../lib/models/item_order.rb'

RSpec.describe Order, type: :model do
  let(:order) { FactoryBot.create(:order) }
  let(:item_a) { FactoryBot.create(:item, :a) }
  let(:item_b) { FactoryBot.create(:item, :b) }

  it "should have a currency" do
    expect(FactoryBot.build(:order, currency_id: nil)).to_not be_valid
  end

  it "can have many items" do
    expect(order).to respond_to(:items)
  end

  context "#update_subtotal!" do
    it "should return the subtotal of an order's items" do
      order.items << [item_a, item_b]
      order.update_subtotal!

      expect(order.subtotal).to eq 8000
    end

    it "should update when items are removed" do
      order.items << [item_a, item_b]
      order.update_subtotal!
      order.items.delete(item_b)
      order.update_subtotal!

      expect(order.subtotal).to eq 5000
    end

    context "#update_total!" do
      it "should return the subtotal if there are no deals" do
        order.items << [item_a, item_b]
        order.update_total!

        expect(order.total).to eq 8000
      end
    end
  end
end
