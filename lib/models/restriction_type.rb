require 'active_record'

class RestrictionType < ActiveRecord::Base
  validates :type, uniqueness: true
end
