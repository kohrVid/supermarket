require 'active_record'

class Currency < ActiveRecord::Base
  validates :code, length: { is: 3 }, uniqueness: true
end
