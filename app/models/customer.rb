class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def sucsessful_transaction_count
    invoices.joins(:transactions).where('transactions.result = ?', 0).count
  end
end
