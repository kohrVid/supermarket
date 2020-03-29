require_relative '../../lib/models/checkout.rb'

RSpec.describe Checkout, type: :model do
  let(:item_a) { Item.find_or_create_by(attributes_for(:item, :a)) }
  let(:item_b) { Item.find_or_create_by(attributes_for(:item, :b)) }

  let(:item_c) do
    Item.find_or_create_by(
      attributes_for(:item, :c, currency_id: Currency.first.id)
    )
  end

  # 2 items A for £90
  let(:pricing_rule_1) { FactoryBot.create(:pricing_rule, :line_items) }

  let(:restriction_group_1) do
    RestrictionGroup.create(pricing_rule_id: pricing_rule_1.id)
  end

  let(:restriction_1) do
    FactoryBot.create(
      :restriction, :miq, restriction_group_id: restriction_group_1.id
    )
  end

  let(:reward_1) { FactoryBot.create(:reward, :value_off) }


  # 3 items B for £75
  let(:pricing_rule_2) { FactoryBot.create(:pricing_rule, :line_items_2) }

  let(:restriction_group_2) do
    RestrictionGroup.create(pricing_rule_id: pricing_rule_2.id)
  end

  let(:restriction_2) do
    FactoryBot.create(
      :restriction, :miq2, restriction_group_id: restriction_group_2.id
    )
  end

  let(:reward_2) do
    FactoryBot.create(
      :reward,
      :value_off,
      pricing_rule_id: pricing_rule_2.id,
      reward_id: RewardType::ValueOff.find_or_create_by(value: 1500).id
    )
  end


  #10% off 200
  let(:pricing_rule_3) { FactoryBot.create(:pricing_rule, :basket) }

  let(:restriction_group_3) do
    RestrictionGroup.create(pricing_rule_id: pricing_rule_3.id)
  end

  let(:restriction_3) do
    FactoryBot.create(
      :restriction, :mov, restriction_group_id: restriction_group_3.id
    )
  end

  let(:reward_3) { FactoryBot.create(:reward, :percent_off) }



  let(:pricing_rules) { [pricing_rule_1, pricing_rule_2, pricing_rule_3] }
  let(:checkout) { Checkout.new(pricing_rules) }

  before do
    restriction_group_1.restrictions << restriction_1
    restriction_group_2.restrictions << restriction_2
    restriction_group_3.restrictions << restriction_3
    reward_1
    reward_2
    reward_3
  end

  context ".new" do
    it "should create a new order even when a currency isn't set " do
      checkout = Checkout.new(pricing_rules)
      expect(checkout.order).to be_valid
      expect(checkout.order.currency.code).to eq "GBP"
    end

    it "should create an order with the right currency if one is given" do
      checkout = Checkout.new(
        pricing_rules,
        nil,
        FactoryBot.create(:currency, :eur)
      )

      expect(checkout.order).to be_valid
      expect(checkout.order.currency.code).to eq "EUR"
    end
  end

  context "#pricing_rules" do
    it "should place pricing rules where apply_last is set to true at the end" do
      expect(checkout.pricing_rules.last).to eq pricing_rule_3
      expect(checkout.pricing_rules.last.apply_last).to eq true
    end
  end

  context "#scan" do
    it "should add an item to an order" do
      checkout.scan(item_a)
      expect(checkout.order.items).to include(item_a)
    end
  end

  context "#total" do
    it "should correctly format the total of a given order" do
      checkout.scan(item_a)
      expect(checkout.total).to eq "£50.00"
    end

    it "should not apply pricing rules to orders that fail restrictions" do
      [item_a, item_b, item_c].each { |item| checkout.scan(item) }

      expect(checkout.total).to eq "£100.00"
      expect(checkout.order.subtotal).to eq 10000
    end

    it "should apply pricing rules to orders" do
      [item_b, item_a, item_b, item_b, item_a].each do |item|
        checkout.scan(item)
      end

      expect(checkout.total).to eq "£165.00"
      expect(checkout.order.subtotal).to eq 19000
    end

    it "should apply pricing rules in the right order" do
      [item_c, item_b, item_a, item_a, item_c, item_b, item_c].each do |item|
        checkout.scan(item)
      end

      expect(checkout.total).to eq "£189.00"
      expect(checkout.order.subtotal).to eq 22000
    end

    it "should only update the total of a given order once" do
      checkout.scan(item_a)
      checkout.scan(item_a)
      checkout.total

      expect(checkout.total).to eq "£90.00"
    end

    it "should update the total again if the order is modified" do
      checkout.scan(item_a)
      checkout.scan(item_a)
      checkout.total
      checkout.scan(item_a)
      checkout.total

      expect(checkout.total).to eq "£140.00"
    end

    it "should return £0 if there are no items in an order" do
      checkout.total
      expect(checkout.total).to eq "£0.00"
    end
  end

  context "#subtotal" do
    it "should correctly format the subtotal of a given order" do
      checkout.scan(item_a)
      expect(checkout.subtotal).to eq "£50.00"
    end
  end
end
