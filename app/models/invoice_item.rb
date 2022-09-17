class InvoiceItem < ApplicationRecord
  enum status: ["Pending", "Packaged", "Shipped"]

  validates_presence_of :item_id
  validates_presence_of :invoice_id
  validates :quantity, presence: :true, numericality: { only_integer: true }
  validates :unit_price, presence: :true, numericality: { only_integer: true }
  validates_presence_of :status, inclusion: ["Pending", "Packaged", "Shipped"]

  belongs_to :item
  belongs_to :invoice

  def self.unshipped_invoice_items
    where.not(status: 2)
  end
end