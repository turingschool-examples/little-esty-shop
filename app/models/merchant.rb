class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  validates_presence_of :name

  def top_five_customers
    Customer.left_joins(:transactions, :items).group(:id).where('transactions.result = ?', 'success')
            .where('items.merchant_id = ?', self.id)
            .order(Arel.sql('COUNT(transactions.id) DESC')).limit(5)
  end
end