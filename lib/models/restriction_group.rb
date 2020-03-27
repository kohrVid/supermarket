require 'active_record'
require_relative './pricing_rule.rb'
require_relative './restriction.rb'

class RestrictionGroup < ActiveRecord::Base
  belongs_to :pricing_rule
  has_many :restrictions

  validates :pricing_rule_id, presence: true
end
