class InvoiceItem < ApplicationRecord
  validates :status, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :item_id, presence: true
  validates :invoice_id, presence: true
  
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  has_many :customers, through: :invoice
  has_many :transactions, through: :invoice

  enum status: { pending: 0, packaged: 1, shipped: 2}
end
