require_relative "../../lib/models/currency.rb"

RSpec.describe Currency, type: :model do
  it "should have a code that complies with ISO 4217" do
    expect(Currency.new(code: "GBP")).to be_valid
    expect(Currency.new(code: "GBP1")).to_not be_valid
    expect(Currency.new(code: "GB")).to_not be_valid
  end
end

