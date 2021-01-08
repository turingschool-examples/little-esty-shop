class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :merchant_id,
                        :customer_id

  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  enum status: [:cancelled, :in_progress, :complete]

  def incomplete_invoices
    item_ids = InvoiceItem.where(status: 0 || status: 1).pluck(:item_id)
    Item.find(item_ids)
  end

end
