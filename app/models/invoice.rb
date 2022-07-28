class Invoice < ApplicationRecord
    enum status: {in_progress: 0, cancelled: 1, completed: 2}

        validates_presence_of :status
        validates_presence_of :created_at
        validates_presence_of :updated_at

        belongs_to :customer
        has_many :invoice_items
        has_many :items, through: :invoice_items
        has_many :transactions
end
