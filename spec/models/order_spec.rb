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

  context "after_add items callback" do
    it "should update an order's subtotal when a single item is added" do
      expect { order.items << item_a }.
        to change{ order.subtotal }.from(0).to(5000)
    end

    it "should update an order's subtotal when multiple items are added" do
      expect { order.items << [item_a, item_b] }.
        to change{ order.subtotal }.from(0).to(8000)
    end

    it "should update an order's total when a single item is added" do
      expect { order.items << item_a }.
        to change{ order.total }.from(0).to(5000)
    end

    it "should update an order's total when multiple items are added" do
      expect { order.items << [item_a, item_b] }.
        to change{ order.total }.from(0).to(8000)
    end
  end

  context "after_destroy items callback" do
    before do
      order.items << [item_a, item_b]
    end

    it "should update an order's subtotal when a single item is removed" do
      expect { order.items.delete(item_a) }.
        to change { order.subtotal }.from(8000).to(3000)
    end

    it "should update an order's subtotal when a multiple items are removed" do
      expect { order.items.delete([item_a, item_b]) }.
        to change { order.subtotal }.from(8000).to(0)
    end

    it "should update an order's total when a single item is removed" do
      expect { order.items.delete(item_a) }.
        to change { order.total }.from(8000).to(3000)
    end

    it "should update an order's total when a multiple items are removed" do
      expect { order.items.delete([item_a, item_b]) }.
        to change { order.total }.from(8000).to(0)
    end
  end
end
