require 'spec_helper'
require_relative "../../lib/models/currency.rb"

RSpec.describe Currency, type: :model do
  context "#code" do
    it "should be unique" do
      FactoryBot.create(:currency)
      expect(FactoryBot.build(:currency)).to_not be_valid
    end

    it "should comply with ISO 4217" do
      expect(Currency.new(code: "GBP")).to be_valid
      expect(Currency.new(code: "GBP1")).to_not be_valid
      expect(Currency.new(code: "GB")).to_not be_valid
    end
  end
end

