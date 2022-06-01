class InvoiceItem < ApplicationRecord
    belongs_to :invoice
    belongs_to :item

    enum status: ['Pending', 'Packaged', 'Shipped']
end
