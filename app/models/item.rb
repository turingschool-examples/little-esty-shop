class Item < ApplicationRecord
  belongs_to :merchant

  def unit_price_to_currency
    "%.2f" % (unit_price.to_f/100).truncate(2)
  end
end
