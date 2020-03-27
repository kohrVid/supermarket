require 'active_record'

class RewardType < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
end
