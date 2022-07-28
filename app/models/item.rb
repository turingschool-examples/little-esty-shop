class Item < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :description
    validates :unit_price, presence: true, numericality: true

    belongs_to :merchant
    has_many :invoice_items, dependent: :destroy
    has_many :invoices, through: :invoice_items
    has_many :transactions, through: :invoices

    enum status: [ :disabled, :enabled ]
end
