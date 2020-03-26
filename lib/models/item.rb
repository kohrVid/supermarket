require 'active_record'
require_relative './restriction_type/minimum_item_quantity.rb'

class Item < ActiveRecord::Base
  belongs_to :currency
  has_many :item_orders
  has_many :minimum_item_quantity_restrictions,
    class_name: "RestrictionType::MinimumItemQuantity"
  has_many :orders, through: :item_orders

  validates :name, presence: true
  validates :currency_id, presence: true
end
