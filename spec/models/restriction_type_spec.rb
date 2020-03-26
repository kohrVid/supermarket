require 'spec_helper'
require_relative "../../lib/models/restriction_type.rb"

RSpec.describe RestrictionType, type: :model do
  context "#type" do
    it "should be unique" do
      FactoryBot.create(:restriction_type, :mov)
      expect(FactoryBot.build(:restriction_type, :mov)).to_not be_valid
    end
  end
end
