class Item < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :description
    validates_presence_of :unit_price
    validates_presence_of :created_at
    validates_presence_of :updated_at

    has_many :invoice_items
end 