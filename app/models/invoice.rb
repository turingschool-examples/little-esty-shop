class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer
  belongs_to :merchant

  validates_presence_of :status

  enum status: ['in progress', :completed, :cancelled]

  def self.incomplete_invoices
    where(status: 0).pluck(:id)
  end

  def date_time
    created_at.strftime("%A, %B %d, %Y")
  end
end
