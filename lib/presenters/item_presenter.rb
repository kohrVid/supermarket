require 'money'

class ItemPresenter
  # The following has been added to resolve deprecation warnings
  Money.rounding_mode = BigDecimal::ROUND_HALF_UP
  Money.locale_backend = :i18n
  I18n.locale = :en

  def initialize(item)
    @item = item
  end

  def format_price
    Money.new(
      @item.price,
      @item.currency.code
    ).format
  end
end
