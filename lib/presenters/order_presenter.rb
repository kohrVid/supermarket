require 'money'
require_relative './item_presenter.rb'
require_relative '../models/item_order.rb'

class OrderPresenter
  # The following has been added to resolve deprecation warnings
  Money.rounding_mode = BigDecimal::ROUND_HALF_UP
  Money.locale_backend = :i18n
  I18n.locale = :en

  def initialize(order)
    @order = order
  end

  def subtotal
    Money.new(
      @order.subtotal,
      @order.currency.code
    ).format
  end

  def total
    Money.new(
      @order.total,
      @order.currency.code
    ).format
  end

  def receipt(calculated_total)
    header = <<-EOF
    Items purchased:

      EOF

    rows = @order.items.map do |item|
      <<-EOF
         ##{item.name} .......... #{ItemPresenter.new(item).format_price}
      EOF
    end.inject("") { |sum, i| sum + i }

    footer = <<-EOF

         Subtotal .... #{subtotal}
         Total ....... #{calculated_total}

    EOF

    header + rows + footer
  end
end
