require 'spec_helper'
require_relative "../../lib/models/pricing_rule.rb"

RSpec.describe PricingRule, group: :model do
  let(:miq_restriction) { FactoryBot.create(:restriction, :miq) }
  let(:mov_restriction) { FactoryBot.create(:restriction, :mov) }
  let(:restriction_group) { FactoryBot.create(:restriction_group) }
  let(:reward) { FactoryBot.create(:reward, :value_off) }
  let(:item_a) { Item.find_or_create_by(attributes_for(:item, :a)) }
  let(:item_b) { Item.find_or_create_by(attributes_for(:item, :b)) }
  let(:order) { FactoryBot.create(:order) }

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
    before do
      reward
      restriction_group.restrictions << [miq_restriction, mov_restriction]
    end

    it "should have a reward" do
      expect(pricing_rule).to respond_to(:reward)
      expect(pricing_rule.reward).to be_an_instance_of(Reward)
    end

    it "should be possible to add many order to a pricing rule" do
      expect(pricing_rule).to respond_to(:pricing_rule_orders)
      expect(pricing_rule).to respond_to(:discounted_orders)
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

  context "#discount_to_apply" do
    let(:pricing_rule_2) do
      PricingRule.find_or_create_by(attributes_for(:pricing_rule, :basket))
    end

    it "should return 0 if the rule is configured without a reward" do
      restriction_group.restrictions << miq_restriction

      expect(pricing_rule_2.discount_to_apply(order)).to eq 0
    end

    context "with reward" do
      before do
        reward
        restriction_group.restrictions << miq_restriction
      end

      it "should return the deduction amount if the only restriction is met" do
        order.items << [item_a, item_a]

        expect(pricing_rule.discount_to_apply(order)).to eq 1000
      end

      it "should return 0 if the no restrictions are met" do
        order.items << item_a

        expect(pricing_rule.discount_to_apply(order)).to eq 0
      end

      it "should return the correct deduction amount if restrictions are met twice" do
        order.items << [item_a, item_a, item_a, item_a]

        expect(pricing_rule.discount_to_apply(order)).to eq 2000
      end

      it "should return the correct reward if all restrictions are met" do
        restriction_group.restrictions << mov_restriction
        order.items << [item_a, item_a, item_a, item_a, item_a]

        # Note, this applies the same £10 off reward three times because the MIQ
        # restriction is met twice and the MOV restriction is met once. Ordinarily,
        # these restrictions would be placed on different pricing rules but this is
        # a useful edge case.
        expect(pricing_rule.discount_to_apply(order)).to eq 3000
      end

      context "pricing_rule_orders" do
        it "should create a row in the pricing_rule_orders table for each rule" do
          order.items << [item_a, item_a]

          expect {
            pricing_rule.discount_to_apply(order)
          }.to change { PricingRuleOrder.count }.from(0).to(1)

          expect(order.applied_discounts).to include(pricing_rule)
        end

        it "should remove rows in the pricing_rule_orders table if they no longer match" do
          order.items << [item_a, item_a]
          pricing_rule.discount_to_apply(order)

          # The following is required because deleting duplicate items from an
          # order is quite difficult and simply removing the ItemOrder record
          # didn't work.
          items = order.items.to_a
          items.delete_at(1)
          order.items = items
          pricing_rule.discount_to_apply(order)

          expect(order.applied_discounts).to_not include(pricing_rule)
        end

        it "shouldn't create duplicate rows in the pricing_rule_orders table" do
          order.items << [item_a, item_a]
          pricing_rule.discount_to_apply(order)

          expect {
            pricing_rule.discount_to_apply(order)
          }.to_not raise_error { ActiveRecord::RecordInvalid }
        end
      end
    end
  end
end
