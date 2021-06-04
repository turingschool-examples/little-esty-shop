class Invoice < ApplicationRecord
  enum status: [:cancelled, :in_progress, :completed]
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.successful_transactions
    joins(:transactions)
    .where(:result = :successful)
    .select(:result,:customer_id)
    .group(:customer_id)
    .count
    .order
  end
  
end
