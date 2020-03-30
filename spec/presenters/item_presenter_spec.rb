require 'spec_helper'
require_relative '../../lib/presenters/item_presenter.rb'

RSpec.describe ItemPresenter, type: :presenter do
  let(:item_a) { FactoryBot.create(:item, :a) }
  let(:item_presenter) { ItemPresenter.new(item_a) }

  context "#format_price" do
    subject { item_presenter.format_price }

    it { is_expected.to eq("£50.00") }
  end
end
