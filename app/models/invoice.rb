class Invoice < ApplicationRecord
    enum status: [:completed, "in progress", :cancelled]

    validates_presence_of :status
    validates_presence_of :created_at
    validates_presence_of :updated_at

    belongs_to :customer 
    has_many :invoice_items
    has_many :transactions 

end 