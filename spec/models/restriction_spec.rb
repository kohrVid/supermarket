require 'spec_helper'
require_relative "../../lib/models/restriction.rb"

RSpec.describe Restriction, type: :model do
  context "#type" do
    it "should be unique" do
      FactoryBot.create(:restriction, :mov)
      expect(FactoryBot.build(:restriction, :mov)).to_not be_valid
    end
  end
end

