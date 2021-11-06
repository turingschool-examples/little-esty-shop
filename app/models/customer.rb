class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def full_name
    first_name + " " + last_name
  end


  def self.admin_favorite_customers
    self.joins(invoices: :transactions)
             .where('transactions.result = ?', 'success')
             .group('customers.id')
             .select('customers.*')
             .order(count: :desc)
             .limit(5)
             .count
  end

end
