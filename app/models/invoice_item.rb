class InvoiceItem < ApplicationRecord
  belongs_to :item, foreign_key: true
  belongs_to :invoice, foreign_key: true
end
