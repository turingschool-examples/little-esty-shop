class InvoiceItem < ApplicationRecord
  enum status: {"pending": 0, "packaged": 1, "shipped": 2}
end