require 'active_record'

class PricingRuleOrder < ActiveRecord::Base
  belongs_to :pricing_rule
  belongs_to :order

  validates_presence_of :pricing_rule_id, :order_id
end
