require 'spec_helper'
require_relative "../../lib/models/item_order.rb"

RSpec.describe ItemOrder, type: :model do
  it "should have an item" do
    expect(FactoryBot.build(:item_order, item_id: nil)).to_not be_valid
  end

  it "should have an order" do
    expect(FactoryBot.build(:item_order, order_id: nil)).to_not be_valid
  end
end
