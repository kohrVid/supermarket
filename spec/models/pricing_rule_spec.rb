require 'spec_helper'
require_relative "../../lib/models/pricing_rule.rb"

RSpec.describe PricingRule, group: :model do
  let(:pricing_rule) { FactoryBot.create(:pricing_rule, :line_items) }

  it "should be valid if the correct attributes are given" do
    expect(FactoryBot.build(:pricing_rule, :line_items)).to be_valid
  end

  context "#name" do
    it "should be present" do
      expect(FactoryBot.build(:pricing_rule, name: "")).to_not be_valid
    end

    it "should be unique" do
      pricing_rule
      expect(FactoryBot.build(:pricing_rule, :line_items)).to_not be_valid
    end
  end
end
