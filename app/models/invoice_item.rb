class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: {'Pending' => 0, 'Packaged' => 1, 'Shipped' => 2 }
end
