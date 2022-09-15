module Priceable
  def price_convert
    dollars = unit_price.to_f/100
    '%.2f' % dollars
  end
end