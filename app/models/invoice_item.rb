class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :merchants, through: :items
  has_many :transactions, through: :invoices

  validates :quantity, presence: true
  validates :unit_price, presence: true

  enum status: {:pending => 0, :packaged => 1, :shipped => 2} #used in the InvoiceItems Controller, Status action

end
