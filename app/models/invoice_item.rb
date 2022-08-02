class InvoiceItem < ApplicationRecord
    enum status:[:pending, :packaged, :shipped]

    belongs_to :invoice
    belongs_to :item
    
    has_one :mmerchant, through: :item
    has_many :transactions, through: :invoice

    validates_presence_of :quantity
    validates_presence_of :unit_price
    validates_presence_of :status

end
