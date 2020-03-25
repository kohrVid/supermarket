require 'spec_helper'
require_relative "../../lib/models/order.rb"

RSpec.describe Order, type: :model do
  let(:order) { FactoryBot.create(:order) }

  it "should have a currency" do
    expect(FactoryBot.build(:order, currency_id: nil)).to_not be_valid
  end

  it "can have many items" do
    expect(order).to respond_to(:items)
  end
end
