require_relative '../../lib/models/checkout.rb'

RSpec.describe Checkout, type: :model do
  let(:checkout) { Checkout.new }
  let(:item_a) { FactoryBot.create(:item, :a) }
  let(:item_b) { FactoryBot.create(:item, :b) }

  context ".new" do
    it "should create a new order even when a currency isn't set " do
      checkout = Checkout.new
      expect(checkout.order).to be_valid
      expect(checkout.order.currency.code).to eq "GBP"
    end

    it "should create an order with the right currency if one is given" do
      checkout = Checkout.new(FactoryBot.create(:currency, :eur))
      expect(checkout.order).to be_valid
      expect(checkout.order.currency.code).to eq "EUR"
    end
  end

  context "#scan" do
    it "should add an item to an order" do
      checkout.scan(item_a)
      expect(checkout.order.items).to include(item_a)
    end
  end

  context "#total" do
    it "should correctly format the total of a given order" do
      checkout.scan(item_a)
      expect(checkout.total).to eq "£50.00"
    end
  end
end
