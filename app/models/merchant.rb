class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  def merchant_invoices
    self.invoices.distinct.order(:id)
  end
end
