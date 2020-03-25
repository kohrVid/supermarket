require 'active_record'

class ItemOrder < ActiveRecord::Base
  belongs_to :item
  belongs_to :order
  validates_presence_of :item_id, :order_id
end
