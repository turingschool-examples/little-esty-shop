class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  validates_presence_of :first_name, :last_name

  def transactions_with_merchant(merchant_id)
    Transaction.joins(invoice: [:customer, {invoice_items: :item}])
               .where(customers: {id: self.id}, items: {merchant_id: merchant_id}, result: 'success')
               .distinct.count
  end
end