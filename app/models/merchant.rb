class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  validates :name, presence: true
                        
    def favorite_customers(count)
      Merchant.find_by_sql("SELECT customers.* FROM customers 
                            JOIN invoices ON customers.id = invoices.customer_id
                            JOIN invoice_items ON invoices.id = invoice_items.invoice_id
                            JOIN items ON invoice_items.item_id = items.id
                            JOIN merchants ON items.merchant_id = merchants.id
                            JOIN transactions on transactions.invoice_id = invoices.id
                            WHERE merchants.id = #{id} AND transactions.result = 0
                            GROUP BY customers.id
                            ORDER BY COUNT(transactions.id) DESC
                            LIMIT #{count}")
    end

    def items_ready_to_ship
      Merchant.find_by_sql("SELECT items.name, invoices.id FROM merchants 
                            JOIN items ON merchants.id = items.merchant_id
                            JOIN invoice_items ON items.id = invoice_items.item_id
                            JOIN invoices ON invoice_items.invoice_id = invoices.id 
                            JOIN transactions ON invoices.id = transactions.invoice_id
                            WHERE merchants.id = #{id} AND invoice_items.status != 2 
                            AND transactions.result = 0 AND invoices.status != 2")
    end
    Merchant.joins(items: [invoice_items: [invoice: :transactions]])
    .where(merchants: { id: 1}, invoice_items: {status: [0,1]}, transactions: {result: 0}, invoices: {status: [0,1]})
Merchant.select(items: :name).where(merchants: { id: 1}, invoice_items: {status: [0,1]}).joins(items: :invoice_items)

  end
