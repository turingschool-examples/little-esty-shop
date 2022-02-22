class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: [:pending, :packaged, :shipped]

  def self.order_by_oldest
    order(:created_at)
  end
end
