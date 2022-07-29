class Item < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :description
    validates_presence_of :status
    validates :unit_price, presence: true, numericality: true

    belongs_to :merchant
    has_many :invoice_items
    has_many :invoices, through: :invoice_items

    enum status: [ :disabled, :enabled ]
end
