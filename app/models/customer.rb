class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices


  def transactions_with(merchant_transaction_ids)
    self.transactions.where(id: merchant_transaction_ids).count
  end
end