require_relative "../../lib/models/item.rb"
require_relative "../../lib/models/order.rb"

FactoryBot.define do
  factory :item_order do
    item_id { create(:item, :a).id }
    order_id { create(:order).id }
  end
end
