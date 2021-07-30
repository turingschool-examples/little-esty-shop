class InvoiceItem < ApplicationRecord
  enum status: { packaged: 0, pending: 1, shipped: 2 }

  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :unit_price, presence: true, numericality: { only_integer: true }
  validates :status, presence: true, inclusion: { in: InvoiceItem.statuses.keys }

  belongs_to :invoice
  belongs_to :item

  def change_status(status)
    update(status: status.downcase)
  end

end
