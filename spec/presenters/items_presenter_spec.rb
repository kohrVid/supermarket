require 'spec_helper'
require_relative '../../lib/presenters/items_presenter.rb'

RSpec.describe ItemsPresenter, type: :presenter do
  let(:pricing_rule) { FactoryBot.create(:pricing_rule, :line_items) }
  let(:item_a) { FactoryBot.create(:item, :a) }
  let(:item_b) { FactoryBot.create(:item, :b) }
  let(:items_presenter) { ItemsPresenter.new([item_a, item_b]) }

  context "#show_all" do
    before do
      item_a
      item_b
      pricing_rule
    end

    it "should display all available items" do
      expect(items_presenter.show_all).to eq(
        <<-EOF
    Products on sale:

      | ID | Name | Price  |
      ----------------------
      |  #{item_a.id} |  A   | £50.00 |
      |  #{item_b.id} |  B   | £30.00 |

    When scanning an item, please use one of the IDs specifed above.
        EOF
      ) 
    end
  end
end
