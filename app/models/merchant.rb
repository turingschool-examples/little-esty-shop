class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  validates :name, presence: true
                        
    def favorite_customers(count)
      customer = Merchant.find_by_sql("SELECT customers.* FROM customers 
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
    
  end
