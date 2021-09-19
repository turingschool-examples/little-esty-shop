class Invoice < ApplicationRecord
  belongs_to :customer
  has_many   :transactions,  dependent: :destroy
  has_many   :invoice_items, dependent: :destroy
  has_many   :items, through: :invoice_items

  def self.merchant_invoices(merchant_id)
    joins(items: :invoice_items).where(items:{merchant_id: merchant_id.to_i})
  end
end
