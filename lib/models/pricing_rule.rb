require 'active_record'

class PricingRule < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
