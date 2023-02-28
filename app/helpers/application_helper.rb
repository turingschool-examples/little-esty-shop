module ApplicationHelper

  def format_price(unit_price_in_cents)
    number_to_currency(unit_price_in_cents.to_f / 100)
  end

  def display_and_order(statuses, default_status)
    statuses.map { |status| status if status != default_status}.unshift(default_status).reject { |stat| stat.nil? }
  end
end
