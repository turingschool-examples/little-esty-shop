class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions

  def self.pending_invoices
    where(status: 'in progress').order(:created_at)
  end
end
