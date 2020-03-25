require 'spec_helper'
require_relative "../../lib/models/item.rb"

RSpec.describe Item, type: :model do
  let(:item) { FactoryBot.create(:item) }

  it "should have a name" do
    expect(FactoryBot.build(:item, name: "")).to_not be_valid
  end

  it "should have a currency" do
    expect(FactoryBot.build(:item, currency_id: nil)).to_not be_valid
  end

  it "can have many orders" do
    expect(item).to respond_to(:orders)
  end
end
