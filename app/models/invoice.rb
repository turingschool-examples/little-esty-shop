class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions

  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:"in progress", :completed, :cancelled]

  # def all_invoices_for_same_merchant
  #   where("merchant_id = ?", self.merchant_id)
  # end

  def all_successful_transactions
    Transaction.all_successful_transactions.where("invoice_id = ?", self.id)
  end

  def self.with_more_than_one_successful_transaction
    binding.pry
    where()
  end
end
