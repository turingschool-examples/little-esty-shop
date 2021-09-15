class InvoiceItem < ApplicationRecord
  belongs_to :item, optional: true
  belongs_to :invoice, optional: true
end
