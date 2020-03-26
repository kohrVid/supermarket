require 'active_record'

class Restriction < ActiveRecord::Base
  validates :type, uniqueness: true
end
