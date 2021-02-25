class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices


  # Can we use ruby for this method?
  def name
    first_name + " " + last_name
  end

  def self.top_five_customers
    joins(:transactions).where("transactions.result = ?", true).group("customers.id").select("customers.*, count('transactions.result') as top_result").order(top_result: :desc).limit(5)

    # joins(:transactions).where(customer.invoices.id == tranaction.invoice_id).order.count(result: 0)
    # successful_customers = Transaction.where(result: true)
    # test = joins(:transactions).group(:customer_id)
    # require "pry";binding.pry
    # select * from .joins(customer.invoice.id == transaction.invoice_id)(as customer_transactions).where(result: true).group.max.count(customer_transactions).limit(5)
    # top_result = successful_customers.map(&:customer_id)
  end

  def successful_count
    # ActiveRecord get number of successful transactions associated with customer
    # Maybe call top_five_customers to access transaction count on invoice
  end
end
