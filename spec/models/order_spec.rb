require 'spec_helper'
require_relative "../../lib/models/order.rb"
require_relative "../../lib/models/item_order.rb"

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

  context "#subtotal" do
    it "should return the total cost of all items with corrections" do
      order.items << [item_a, item_b]
      expect(order.subtotal).to eq 80
    end
  end
end
