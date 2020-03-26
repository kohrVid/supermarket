require 'spec_helper'
require_relative '../../lib/models/item.rb'
require_relative '../../lib/models/restriction_type/minimum_item_quantity.rb'

RSpec.describe Item, type: :model do
  let(:item) { FactoryBot.create(:item, :a) }

  it "should have a name" do
    expect(FactoryBot.build(:item, :a, name: "")).to_not be_valid
  end

  it "should have a currency" do
    expect(FactoryBot.build(:item, :a, currency_id: nil)).to_not be_valid
  end

  context "associations" do
    it "can have many minimum item quantities" do
      expect(item).to respond_to(:minimum_item_quantity_restrictions)
    end

    it "can have many orders" do
      expect(item).to respond_to(:orders)
    end
  end
end
