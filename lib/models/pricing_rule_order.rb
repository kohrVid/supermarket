require 'active_record'

class PricingRuleOrder < ActiveRecord::Base
  belongs_to :pricing_rule
  belongs_to :order

  validates :pricing_rule_id, presence: true, uniqueness: { scope: :order_id }
  validates :order_id, presence: true
end
