class InvoiceItem < ApplicationRecord
  belongs_to :item, foreign_key: true
  belongs_to :invoice, foreign_key: true

  enum status: {pending: 'Pending', packaged: 'Packaged', shipped: 'Shipped'}
end
