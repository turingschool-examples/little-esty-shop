class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  has_many :transactions, through: :invoice
end
