class Invoice < ApplicationRecord
    enum status: [:completed, "in progress", :cancelled]

    validates_presence_of :status
    validates_presence_of :created_at
    validates_presence_of :updated_at
    has_many :invoice_items, dependent: :destroy
    has_many :transactions, dependent: :destroy
    has_many :items, through: :invoice_items

    belongs_to :customer 
    has_many :invoice_items
end 