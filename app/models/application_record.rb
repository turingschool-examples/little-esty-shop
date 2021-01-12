class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def total_revenue
    invoice_items.sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
