class InvoiceItem < ApplicationRecord
  validates_presence_of :unit_price,
                        :status,
                        :quantity
  belongs_to :invoice
  belongs_to :item

  enum status: { "Pending" => 0, "Packaged" => 1, "Shipped" => 2  }

end
