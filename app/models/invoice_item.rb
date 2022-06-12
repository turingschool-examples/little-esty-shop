class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  validates_numericality_of :quantity
  validates_numericality_of :unit_price
  enum status:["pending", "packaged", "shipped"]

  def unit_price_converted
    helpers.number_to_currency(self.unit_price.to_f/100)
  end

  def revenue_before_discount
    unit_price * quantity
  end

  def find_discount
    x = item.merchant.bulk_discounts.select("bulk_discounts.*")
    .where('bulk_discounts.threshold <= ?', quantity)
    .order('bulk_discounts.discount_percentage DESC')
    .first
  end

private
  # Helper Methods
  def helpers
  ActionController::Base.helpers
  end
end
