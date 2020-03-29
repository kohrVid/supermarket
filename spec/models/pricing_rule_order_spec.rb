require 'spec_helper'
require_relative '../../lib/models/pricing_rule_order.rb'

RSpec.describe PricingRuleOrder, type: :model do
  it "should have an pricing_rule" do
    expect(FactoryBot.build(:pricing_rule_order, pricing_rule_id: nil)).to_not be_valid
  end

  it "should have an order" do
    expect(FactoryBot.build(:pricing_rule_order, order_id: nil)).to_not be_valid
  end
end
