require 'colorize'
require 'database_cleaner'
require_relative '../lib/models/checkout.rb'

database_name = Rails.configuration.database_configuration[Rails.env]["database"]
DatabaseCleaner.clean_with :truncation

if ENV["deseed"]
  puts "Successfully deleted all rows in #{ database_name}".colorize(:green)
else
  gbp = Currency.find_or_create_by(code: "GBP")
  miq = RestrictionType.find_or_create_by(name: "Minimum Item Quantity")
  mov = RestrictionType.find_or_create_by(name: "Minimum Order Value")
  percent_off = RewardType.find_or_create_by(name: "Percent Off")
  value_off = RewardType.find_or_create_by(name: "Value Off")

  item_a = Item.find_or_create_by(name: "A", price: 5000, currency_id: gbp.id)
  item_b = Item.find_or_create_by(name: "B", price: 3000, currency_id: gbp.id)
  item_c = Item.find_or_create_by(name: "C", price: 2000, currency_id: gbp.id)


  # 2 items A for £90
  pricing_rule_1 = PricingRule.find_or_create_by(name: "2 items A for £90")

  restriction_group_1 = RestrictionGroup.create(
    pricing_rule_id: pricing_rule_1.id
  )

  restriction_body_1 = RestrictionType::MinimumItemQuantity.find_or_create_by(
    item_id: item_a.id,
    quantity: 2
  )

  restriction_1 = Restriction.find_or_create_by(
    restriction_group_id: restriction_group_1.id,
    restriction_type_id: miq.id,
    restriction_id: restriction_body_1.id
  )

  reward_1 = Reward.create(
    pricing_rule_id: pricing_rule_1.id,
    reward_type_id: value_off.id,
    reward_id: RewardType::ValueOff.find_or_create_by(value: 1000).id
  )


  # 3 items B for £75

  pricing_rule_2 = PricingRule.find_or_create_by(name: "3 items B for £75")

  restriction_group_2 = RestrictionGroup.create(
    pricing_rule_id: pricing_rule_2.id
  )

  restriction_body_2 = RestrictionType::MinimumItemQuantity.find_or_create_by(
    item_id: item_b.id,
    quantity: 3
  )

  restriction_2 = Restriction.find_or_create_by(
    restriction_group_id: restriction_group_2.id,
    restriction_type_id: miq.id,
    restriction_id: restriction_body_2.id
  )

  reward_2 = Reward.create(
    pricing_rule_id: pricing_rule_2.id,
    reward_type_id: value_off.id,
    reward_id: RewardType::ValueOff.find_or_create_by(value: 1500).id
  )


  #10% off 200

  pricing_rule_3 = PricingRule.find_or_create_by(
    name: "10% off total basket cost for baskets worth over £200"
  )

  restriction_group_3 = RestrictionGroup.find_or_create_by(
    pricing_rule_id: pricing_rule_3.id
  )

  restriction_body_3 = RestrictionType::MinimumOrderValue.find_or_create_by(
    value: 20000
  )

  restriction_3 = Restriction.find_or_create_by(
    restriction_group_id: restriction_group_3.id,
    restriction_type_id: mov.id,
    restriction_id: restriction_body_3.id
  )

  reward_3 = Reward.create(
    pricing_rule_id: pricing_rule_3.id,
    reward_type_id: percent_off.id,
    reward_id: RewardType::PercentOff.find_or_create_by(percentage: 10.0).id
  )

  pricing_rules = [ pricing_rule_1, pricing_rule_2, pricing_rule_3 ]

  puts "Successfully seeded rows in #{ database_name}".colorize(:green)
end
