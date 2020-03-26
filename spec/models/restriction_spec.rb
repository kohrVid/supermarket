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
    let(:restriction) { FactoryBot.create(:restriction, :miq) }

    it "should belong to a restriction group" do
      expect(restriction).to respond_to(:group)
    end

    it "should belong to a restriction type" do
      expect(restriction).to respond_to(:type)
    end
  end
end
