require 'spec_helper'
require_relative '../../lib/models/pricing_rule_order.rb'

RSpec.describe PricingRuleOrder, type: :model do
  it "should be valid if instantiated with the correct attributes" do
    expect(FactoryBot.build(:pricing_rule_order)).to be_valid
  end

  it "should have an pricing rule ID" do
    expect(
      FactoryBot.build(:pricing_rule_order, pricing_rule_id: nil)
    ).to_not be_valid
  end

  it "should have an order ID" do
    expect(
      FactoryBot.build(:pricing_rule_order, order_id: nil)
    ).to_not be_valid
  end

  it "should be unique" do
    FactoryBot.create(:pricing_rule_order)

    expect(FactoryBot.build(:pricing_rule_order)).to_not be_valid
  end

  context "associations" do
    let(:pricing_rule_order) { FactoryBot.create(:pricing_rule_order) }

    it "should have an order" do
      expect(pricing_rule_order).to respond_to(:order)
    end

    it "should have a pricing rule" do
      expect(pricing_rule_order).to respond_to(:pricing_rule)
    end
  end
end
