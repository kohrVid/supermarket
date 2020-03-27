require 'active_record'

class RestrictionType < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
end
