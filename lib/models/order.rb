require 'active_record'

class Order < ActiveRecord::Base
  belongs_to :currency
  validates :currency_id, presence: true
end
