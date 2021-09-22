class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item

  enum status: {
    packaged: 0,
    pending: 1,
    shipped: 2
  }

  def create
  end

  def total_revenue
    unit_price * quantity
  end
end
