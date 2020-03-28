require 'active_record'
require_relative './reward.rb'

class PricingRule < ActiveRecord::Base
  has_one :restriction_group
  has_one :reward
  has_many :restrictions, through: :restriction_group

  validates :name, presence: true, uniqueness: true

  def apply_reward(order)
    check_all_restrictions = restrictions.map do |restriction|
      restriction.check(order)
    end

    if check_all_restrictions.map(&:first).exclude?(false)
      check_all_restrictions.map(&:second).reduce(:+).times do
        reward.body.apply(order)
      end
    end
  end

  def restrictions
    Array(restriction_group).flat_map do |group|
      group.restrictions.map(&:body)
    end
  end
end
