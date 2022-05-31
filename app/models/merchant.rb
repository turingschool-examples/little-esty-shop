class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name

  def items_ready_to_ship
    merchant_items = Item.where("merchant_id = #{self.id}")
    InvoiceItem.where(item_id: merchant_items).where(status: [0,1]).order(:created_at)
  end


  def top_5_customers
    merchant_items_ids = Item.where(merchant_id: id).pluck(:id)
    invoice_ids = Invoice.joins(:items).where(items: { id: merchant_items_ids }).pluck(:id)
    successful_invoice_ids = Invoice.joins(:transactions).where(id: invoice_ids).where(transactions: { result: "success" }).pluck(:id)
    #returns hash, key: customer_id value: number of invoices for customer
    customer_invoice_count = Invoice.where(id: successful_invoice_ids).group(:customer_id).count
    customer_sorted = customer_invoice_count.sort_by {|id, count| count}
    top_5 = customer_sorted.last(5)
    customer_ids = top_5.map { |pair| pair[0] }
    customers_5 = Customer.where(id: customer_ids).to_a
  end

end
