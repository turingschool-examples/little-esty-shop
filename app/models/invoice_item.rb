class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity,
                        :unit_price,
                        :status
  belongs_to :invoice
  belongs_to :item
end
