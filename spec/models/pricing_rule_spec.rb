require 'spec_helper'
require_relative "../../lib/models/pricing_rule.rb"
require_relative "../../lib/models/item_order.rb"

RSpec.describe PricingRule, group: :model do
  let(:miq_restriction) { FactoryBot.create(:restriction, :miq) }
  let(:mov_restriction) { FactoryBot.create(:restriction, :mov) }
  let(:restriction_group) { FactoryBot.create(:restriction_group) }

  let(:pricing_rule) do
    PricingRule.find_or_create_by(attributes_for(:pricing_rule, :line_items))
  end

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

  context "associations" do
    let(:reward) { FactoryBot.create(:reward, :value_off) }

    before do
      reward
      restriction_group.restrictions << [miq_restriction, mov_restriction]
    end

    it "should have a reward" do
      expect(pricing_rule).to respond_to(:reward)
      expect(pricing_rule.reward).to be_an_instance_of(Reward)
    end

    it "should have a restriction group" do
      expect(pricing_rule).to respond_to(:restriction_group)

      expect(
        pricing_rule.restriction_group
      ).to be_an_instance_of(RestrictionGroup)
    end

    context "#restrictions" do
      it "can have many restrictions" do
        expect(pricing_rule).to respond_to(:restrictions)
      end

      it "can have restrictions of varying types" do
        expect(
          pricing_rule.restrictions.first
        ).to be_an_instance_of(RestrictionType::MinimumItemQuantity)

        expect(
          pricing_rule.restrictions.second
        ).to be_an_instance_of(RestrictionType::MinimumOrderValue)
      end

      it "should return an empty array if no restrictions have been added" do
        pricing_rule_2 = PricingRule.find_or_create_by(
          attributes_for(:pricing_rule, :basket)
        )

        expect(pricing_rule_2.restrictions).to be_empty
      end
    end
  end

  context "#check_restrictions" do
    let(:item_a) { Item.find_or_create_by(attributes_for(:item, :a)) }
    let(:item_b) { Item.find_or_create_by(attributes_for(:item, :b)) }
    let(:item_c) { FactoryBot.create(:item, :c, currency_id: Currency.first.id) }
    let(:order) { FactoryBot.create(:order) }

    it "should return true if an order meets a single restriction" do
      restriction_group.restrictions << [miq_restriction]
      order.items << [item_a, item_a]

      expect(pricing_rule.check_restrictions(order)).to eq true
    end

    it "should return false if an order fails to meet a single restriction" do
      restriction_group.restrictions << [miq_restriction]
      order.items << item_a

      expect(pricing_rule.check_restrictions(order)).to eq false
    end

    it "should return true if an order meets all restrictions" do
      restriction_group.restrictions << [miq_restriction, mov_restriction]
      order.items << [
        item_a, item_a, item_b, item_c, item_b, item_c
      ]

      expect(pricing_rule.check_restrictions(order)).to eq true
    end

    it "should return false if an order fails to meet any of the restrictions" do
      restriction_group.restrictions << [miq_restriction, mov_restriction]
      order.items << [
        item_a, item_b, item_c, item_b, item_c
      ]

      expect(pricing_rule.check_restrictions(order)).to eq false
    end
  end
end
