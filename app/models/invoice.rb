class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  belongs_to :merchant
  
  validates_presence_of :status

  enum status: ['in progress', :completed, :cancelled]

  def self.incomplete_invoices
    where(status: 0).pluck(:id)
  end
end
