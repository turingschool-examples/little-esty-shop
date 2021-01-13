class Merchant < ApplicationRecord
    has_many :invoices
    has_many :customers, through: :invoices
    has_many :items

    def best_customers
      Invoice.where(merchant_id: self.id)
             .joins(:transactions, :customer)
             .select('customers.*, count(transactions) as most_success')
             .where('transactions.result = ?', 0)
             .group('customers.id')
             .order('most_success desc')
             .limit(5)
    end

    def self.items_ready_to_ship(id)
              where(id: id)
             .joins(invoices: :items)
             .select('items.name')
             .where('invoice_items.status < ?', 2)
             .group('items.name, merchants.id')
    end

    def items_ready_to_ship_id(m_id, name)
      Invoice.where(merchant_id: m_id)
             .joins(:items)
             .select(:id)
             .where('items.name = ?', name)
             .ids
    end
end





#Transaction.joins(invoice: :customer).select('customers.*, count(transactions) as total_success').where('transactions.result = ?', 1).group('customers.id').order('total_success DESC').limit(5)
