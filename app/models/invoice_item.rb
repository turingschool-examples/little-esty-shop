class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item

  validates_presence_of :quantity,
                        :unit_price,
                        :status,
                        :item_id,
                        :invoice_id

  enum status: [:pending, :packaged, :shipped]

  def self.total_revenue
    int = sum("quantity * unit_price")
    sprintf("%.2f", int)
  end
end
