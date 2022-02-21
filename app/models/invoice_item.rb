class InvoiceItem < ApplicationRecord
  validates_presence_of :unit_price,
                        :status,
                        :quantity
  belongs_to :invoice
  belongs_to :item

  enum status: { "pending" => 0, "packaged" => 1, "shipped" => 2  }

end
