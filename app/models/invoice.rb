class Invoice < ApplicationRecord
    enum status: [:completed, "in progress", :cancelled]

    validates_presence_of :status
    validates_presence_of :created_at
    validates_presence_of :updated_at

    belongs_to :customer 
    has_many :invoice_items
    has_many :transactions 

    def self.incomplete_invoices_not_shipped
        select('invoices.*').distinct.joins(:invoice_items).where.not(invoice_items: {status: 2}).order('created_at ASC')
    end

end 