class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates_presence_of :first_name, :last_name

  def self.top_5_transactions 
    self.joins(:transactions)
        .group("customers.id")
        .where(transactions: { result: "success" } )
        .order(Arel.sql("count(transactions.id) desc"))
        .limit(5)
  end

  def successful_transactions_count
    transactions.success.count
  end
  
  def self.top_customers
    self.joins(:merchants, :transactions)
            .where(transactions: { result: "success" } )
            .group(:id)
            .order(Arel.sql("count(transactions.id) desc"))
            .limit(5)
  end

  def complete_name
    "#{first_name} #{last_name}"
  end

end