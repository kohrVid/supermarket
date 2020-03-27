require 'spec_helper'
require_relative "../../lib/models/restriction_type.rb"

RSpec.describe RestrictionType, type: :model do
  it "should be valid with the correct attributes" do
    expect(FactoryBot.build(:restriction_type, :mov)).to be_valid
  end

  context "#name" do
    it "should be present" do
      expect(FactoryBot.build(:restriction_type)).to_not be_valid
    end

    it "should be unique" do
      FactoryBot.create(:restriction_type, :mov)
      expect(FactoryBot.build(:restriction_type, :mov)).to_not be_valid
    end
  end
end
