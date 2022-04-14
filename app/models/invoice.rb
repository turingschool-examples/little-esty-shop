class Invoice < ApplicationRecord
  validates :status, presence: true

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: {:cancelled => 0, "in progress" => 1, :completed => 2}

  def total_revenue
    # InvoiceItem.all(@invoice_item.quantity * @invoice_item.unit_price).sum
    tr = []
    invoice_items.each do |invoice_item|
      product = invoice_item.quantity * invoice_item.unit_price
      tr << product
    end
    tr.sum
  end
end
