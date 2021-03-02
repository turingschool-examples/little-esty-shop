class Customer < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def self.top_customers
      joins(:invoices, :transactions)
      .where('transactions.result = ?', "success")
      .group('customers.id')
      .select('customers.*, count(*) AS transaction_count')
      .order('transaction_count DESC')
      .limit(5)
  end
end
