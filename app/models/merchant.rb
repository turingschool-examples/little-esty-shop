class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices


  def potential_user_story_3
    @merchant.transactions.select('invoices.customer_id, count(transactions.result) as transaction_count').where('transactions.result = 1').group('invoices.customer_id').order('transaction_count DESC').limit(5)
    def top_5
      @merchant.invoices.joins({customers: :transactions).select('customers.*, count(transactions.result) as transaction_count').where('transactions.result = ? && invoices.merchant_id = ?', 1, @merchant.id).group(:id).order('transaction_count DESC').limit(5)
    end
  end
end
