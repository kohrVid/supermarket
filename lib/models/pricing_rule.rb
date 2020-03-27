require 'active_record'
require_relative './reward.rb'

class PricingRule < ActiveRecord::Base
  has_one :restriction_group
  has_one :reward
  has_many :restrictions, through: :restriction_group

  validates :name, presence: true, uniqueness: true

  def restrictions
    Array(restriction_group).flat_map do |group|
      group.restrictions.map(&:body)
    end
  end
end
