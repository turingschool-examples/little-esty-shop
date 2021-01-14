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

  def invoices_for_items_rdy_to_ship(m_id, name)
    Invoice.where(merchant_id: m_id)
           .joins(:items)
           .select(:id, :created_at)
           .where('items.name = ?', name)
           .order('created_at asc')
  end

  def enabled_items
    Item.all_enabled_items.where(merchant_id: self.id)
  end

  def disabled_items
    Item.all_disabled_items.where(merchant_id: self.id)
  end

  def best_customers
    Invoice.where(merchant_id: self.id)
           .joins(:transactions, :customer)
           .select('customers.*, count(transactions) as most_success')
           .where('transactions.result = ?', 0)
           .group('customers.id')
           .order('most_success desc')
           .limit(5)
  end
end
