# app/models/invoice

class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy
  
  def self.find_invoice_created_at(item_id)
    joins(:items).where("#{item_id} = invoice.id").pluck(:created_at).first
  end
end
