require 'money'
require_relative './item_presenter.rb'

class ItemsPresenter
  # The following has been added to resolve deprecation warnings
  Money.rounding_mode = BigDecimal::ROUND_HALF_UP
  Money.locale_backend = :i18n
  I18n.locale = :en

  def initialize(items)
    @items = items
  end

  def show_all
    header = <<-EOF
    Products on sale:

      | ID | Name | Price  |
      ----------------------
      EOF

    rows = @items.map do |item|
      <<-EOF
      |  #{item.id} |  #{item.name}   | #{ItemPresenter.new(item).format_price} |
      EOF
    end.reduce(:+)

    footer = <<-EOF

    When scanning an item, please use one of the IDs specifed above.
    EOF

    header + rows + footer
  end
end
