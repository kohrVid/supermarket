require 'active_record'

class Item < ActiveRecord::Base
  belongs_to :currency
  validates :name, presence: true
  validates :currency_id, presence: true
end
