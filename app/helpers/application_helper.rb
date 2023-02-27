module ApplicationHelper

  def format_price(unit_price_in_cents)
    number_to_currency(unit_price_in_cents.to_f / 100)
  end
end
