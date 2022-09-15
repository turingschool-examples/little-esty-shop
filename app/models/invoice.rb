class Invoice < ApplicationRecord

  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:in_progress, :completed, :cancelled]

  def merchant_items(merchant)
    items
      .where(merchant: merchant)
      .select('items.name, invoice_items.*')
  end

end
