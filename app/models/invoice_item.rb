class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: {'pending' => 0, 'shipped' => 1, 'packaged' => 2}
end
