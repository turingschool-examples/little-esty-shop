class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices

  validates_presence_of :first_name, :last_name 

  def successful_transactions_with_merchant(merch)
    merchant_items = Item.where(merchant_id: merch.id)
    customer_merchant_invoices = Invoice.joins(:items).where(items: { id: merchant_items }).where(customer_id: id).distinct
    successful_transactions = Invoice.joins(:transactions).where(id: customer_merchant_invoices).where(transactions: { result: "success" }).count
  end
  
  def self.top_5_by_successful_transactions
    joins(invoices: :transactions)
            .where(transactions: {result: "success"})
            .select('customers.*, count(transactions.*) AS successful_transactions')
            .group('customers.id')
            .order(successful_transactions: :desc)
            .limit(5)
  end

  def successful_transactions
    st = transactions.where(transactions: {result: "success"})
    st.count
  end
end