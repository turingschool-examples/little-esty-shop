class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  enum staus: ["pending","packaged", "shipped"]
end
