require 'spec_helper'
require_relative '../../../lib/models/restriction_type/minimum_item_quantity.rb'

RSpec.describe RestrictionType::MinimumItemQuantity, type: :model do
  let(:minimum_item_quantity) do
    FactoryBot.create(:minimum_item_quantity, :two_of_a)
  end

  it "should be unique" do
    minimum_item_quantity

    expect(
      FactoryBot.build(
        :minimum_item_quantity,
        :two_of_a,
      )
    ).to_not be_valid
  end

  context "#item" do
    it "should belong to an item" do
      expect(minimum_item_quantity).to respond_to(:item)
    end
  end

  context "#item_id" do
    it "should be present" do
      expect(
        FactoryBot.build(
          :minimum_item_quantity,
          :two_of_a,
          item_id: nil
        )
      ).to_not be_valid
    end
  end

  context "#quantity" do
    it "should be above 0" do
      expect(
        FactoryBot.build(
          :minimum_item_quantity,
          :two_of_a,
          quantity: 0
        )
      ).to_not be_valid
    end
  end
end
