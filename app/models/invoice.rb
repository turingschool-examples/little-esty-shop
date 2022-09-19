class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: { "in progress": 0, completed: 1, cancelled: 2 }

  def self.unshipped_invoices
    joins(:invoice_items).where.not(invoice_items: {status: 2})
  end

  def self.successful_transactions_count
    sum do |invoice| 
      invoice.transactions.where(result: 0).count
    end
  end

  def self.invoice_successful_trans 
    joins(:transactions).where(transactions: {result: :success}).distinct
  end

  def self.sort_by_date
    order(:created_at)
  end
end
