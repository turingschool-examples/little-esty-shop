class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :items

  def top_5_customers
    Customer.joins("INNER join invoices ON invoices.customer_id = customers.id")
            .joins("INNER join transactions ON transactions.invoice_id = invoices.id")
            .joins("INNER join invoice_items ON invoice_items.invoice_id = invoices.id")
            .joins("INNER join items ON invoice_items.item_id = items.id")
            .joins("INNER join merchants ON items.merchant_id = merchants.id")
            .where("transactions.result = 1 and merchants.id = #{self.id}")
            .group(:first_name)
            .order('count_id desc')
            .limit(5)
            .count('id')

    #add last name in group and iterate through key in 
    # .joins(invoices: [:transactions, {items: :merchant}])
    #in test eq([array of them]) should work
  end

  def items_ready_to_ship
    invoice_items.where("invoice_items.status = 1").order('created_at asc')
  end

  def top_5_items
    Item.joins([:merchant, {invoices: :transactions}])
        .where(merchants: {id: self.id}, transactions: {result: 1}, invoices: {status: 2})
        .group(:id, :name)
        .order(Arel.sql("sum(quantity * invoice_items.unit_price) desc"))
        .limit(5)
        .sum('quantity * invoice_items.unit_price')
  end
end

