require 'spec_helper'
require_relative '../../lib/models/restriction_group.rb'

RSpec.describe RestrictionGroup, group: :model do
  let(:restriction_group) { FactoryBot.create(:restriction_group) }

  it "should be valid is created with the correct attributes" do
    expect(FactoryBot.build(:restriction_group)).to be_valid
  end

  context "#pricing_rule_id" do
    it "should be present" do
      expect(
        FactoryBot.build(:restriction_group, pricing_rule_id: nil)
      ).to_not be_valid
    end
  end

  context "associations" do
    let(:miq_restriction) { FactoryBot.create(:restriction, :miq) }
    let(:mov_restriction) { FactoryBot.create(:restriction, :mov) }

    it "should belong to a pricing rule" do
      expect(restriction_group).to respond_to(:pricing_rule)
      expect(restriction_group.pricing_rule).to be_an_instance_of(PricingRule)
    end

    it "should have many restrictions" do
      restriction_group.restrictions << [miq_restriction, mov_restriction]

      expect(restriction_group).to respond_to(:restrictions)
      expect(
        restriction_group.restrictions.first
      ).to be_an_instance_of(Restriction)
    end
  end
end
