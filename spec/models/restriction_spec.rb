require 'spec_helper'
require_relative "../../lib/models/restriction.rb"

RSpec.describe Restriction, group: :model do
  context "#restriction_id" do
    it "should be present" do
      expect(
        FactoryBot.build(:restriction)
      ).to_not be_valid
    end
  end

  context "#restriction_group_id" do
    it "should be present" do
      expect(
        FactoryBot.build(:restriction, :miq, restriction_group_id: nil)
      ).to_not be_valid
    end
  end

  context "#restriction_type_id" do
    it "should be present" do
      expect(
        FactoryBot.build(:restriction, :miq, restriction_type_id: nil)
      ).to_not be_valid
    end
  end

  context "associations" do
    let(:miq_restriction) { FactoryBot.create(:restriction, :miq) }
    let(:mov_restriction) { FactoryBot.create(:restriction, :mov) }

    it "should belong to a restriction group" do
      expect(miq_restriction).to respond_to(:group)
      expect(miq_restriction.group).to be_an_instance_of(RestrictionGroup)
    end

    it "should belong to a restriction type" do
      expect(miq_restriction).to respond_to(:type)
      expect(miq_restriction.type).to be_an_instance_of(RestrictionType)
    end

    context "#body" do
      it "should return the correct row if the restriction is a minimum item quantity type" do
        expect(
          miq_restriction.body
        ).to eq(RestrictionType::MinimumItemQuantity.last)
      end

      it "should return the correct row if the restriction is a minimum order value type" do
        expect(
          mov_restriction.body
        ).to eq(RestrictionType::MinimumOrderValue.last)
      end
    end
  end
end
