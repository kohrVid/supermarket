require 'active_record'

class Item < ActiveRecord::Base
  belongs_to :currency
  has_many :item_orders
  has_many :orders, through: :item_orders
  validates :name, presence: true
  validates :currency_id, presence: true
end
