require 'spec_helper'
require_relative '../../lib/presenters/order_presenter.rb'

RSpec.describe OrderPresenter, type: :presenter do
  let(:pricing_rule) { FactoryBot.create(:pricing_rule, :line_items) }
  let(:item_a) { FactoryBot.create(:item, :a) }
  let(:item_b) { FactoryBot.create(:item, :b) }
  let(:order) { FactoryBot.create(:order) }
  let(:order_presenter) { OrderPresenter.new(order) }

  before do
    order.items << [item_a, item_b]
    pricing_rule
  end

  context "#receipt" do
    context "with items" do
      subject { order_presenter.receipt("£75.00") }

      it do
        is_expected.to eq(
          <<-EOF
    Items purchased:

         #A .......... £50.00
         #B .......... £30.00

         Subtotal .... £80.00
         Total ....... £75.00

          EOF
        )
      end
    end

    context "with no items" do
      before do
        order.items = []
      end

      subject { order_presenter.receipt("£0.00") }

      it do
        is_expected.to eq(
          <<-EOF
    Items purchased:


         Subtotal .... £0.00
         Total ....... £0.00

          EOF
        )
      end
    end
  end

  context "#subtotal" do
    subject { order_presenter.subtotal }

    it { is_expected.to eq("£80.00") }
  end

  context "#total" do
    subject { order_presenter.total }

    it { is_expected.to eq("£80.00") }
  end
end
