class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_5_customers
    Customer.joins("INNER join invoices ON invoices.customer_id = customers.id").joins("INNER join transactions ON transactions.invoice_id = invoices.id").joins("INNER join invoice_items ON invoice_items.invoice_id = invoices.id").joins("INNER join items ON invoice_items.item_id = items.id").joins("INNER join merchants ON items.merchant_id = merchants.id").where("transactions.result = 1 and merchants.id = #{self.id}").group(:first_name).order('count_id desc').limit(5).count('id')
  end
end




