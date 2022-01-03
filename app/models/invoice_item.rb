class InvoiceItem < ApplicationRecord
  belongs_to :items
  belongs_to :invoices
  enum status: ['pending', 'packaged', 'shipped']

end
