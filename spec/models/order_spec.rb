require 'spec_helper'
require_relative "../../lib/models/order.rb"

RSpec.describe Order, type: :model do
  it "should have a currency" do
    expect(FactoryBot.build(:order, currency_id: nil)).to_not be_valid
  end
end
