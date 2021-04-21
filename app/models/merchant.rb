class Merchant < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true

  has_many :items, dependent: :destroy

  enum status: [ :enabled, :disabled ]

####### dashboard methods #########

  def ship_ready
    Merchant.joins(items: {invoice_items: :invoice})
      .where("merchants.id = ?", self.id).where("invoices.status != ?", 1).where("invoice_items.status != ?", 2)
      .order("invoices.created_at").pluck("items.name", "invoices.id", "invoices.created_at")
  end

  def top_five_customers
    Merchant.joins(items: {invoice_items: {invoice: {transactions: {invoice: :customer}}}})
        .where("merchants.id = ?", self.id).where("result = ?", 1).limit(5)
        .group('customers.id', 'customers.first_name', 'customers.last_name').order(count: :desc).count
  end

<<<<<<< HEAD
=======
  def ship_ready
    Merchant.joins(items: {invoice_items: :invoice})
      .where("merchants.id = ?", self.id).where("invoices.status != ?", 1).where("invoice_items.status != ?", 2)
      .order("invoices.created_at").pluck("items.name", "invoices.id", "invoices.created_at")
  end


>>>>>>> main
####### item methods ##############

  def top_five_items  #by revenue
    items.joins(invoice_items: {invoices: :transactions})
         .where("transactions.result = ?", 1)
         .group('item_id').limit(5)
         .order(revenue: :desc)
         .select('item.*, (invoice_items.quantity * invoice_items.unit_price)'' as revenue')
  end


  # binding.pry

#   def top_merchant
#     # invoices.joins(:transactions, :merchant)
#     invoices.joins(:transactions, invoice_items: {item: :merchant})
#             .where(transactions: {result: :success})
#             .order(revenue: :desc).limit(5)
#             .group('merchant_id')
#             .select('merchant.*, sum(invoice_items.quantity * invoice_items.unit_price)' as revenue')
#   end
#
# # .select('merchant.*, sum(invoice_items.quantity * invoice_items.unit_price)' desc')



  # def self.top_five
  #   joins(invoices: :transactions)
  #   .group(:id)
  #   .where("transactions.result = ?", 1)
  #   .select("customers.*, count(transactions.id) as num_transactions")
  #   .order(num_transactions: :desc)
  #   .limit(5)
  # end   ##Customer

  # def self.find_all_invoices_not_shipped
  #   joins(:invoice_items)
  #   .where.not("invoice_items.status = ?", 2)
  #   .order(created_at: :desc)
  #   .distinct
  # end   ##Invoice

  #   def self.top_five_by_revenue
  #   Merchant.joins(items: {invoice_items: {invoice: :transactions}})
  #   .where("transactions.result = ?", 1)
  #   .group(:id)
  #   .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
  #   .order(total_revenue: :desc)
  #   .limit(5)
  # end   ##ADMIN
  #
  # def best_day
  #   self.items
  #   .joins(invoice_items: {invoice: :transactions})
  #   .where("transactions.result = ?", 1)
  #   .group("invoices.id")
  #   .select("invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
  #   .order(total_revenue: :desc)
  #   .first
  #   .created_at
  # end   ##ADMIN


###### invoice methods ###########



<<<<<<< HEAD
=======

###### invoice methods ###########

########### admin ############
  def self.top_five_by_revenue
    Merchant.joins(items: {invoice_items: {invoice: :transactions}})
    .where("transactions.result = ?", 1)
    .group(:id)
    .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
    .order(total_revenue: :desc)
    .limit(5)
  end

  def best_day
    self.items
    .joins(invoice_items: {invoice: :transactions})
    .where("transactions.result = ?", 1)
    .group("invoices.id")
    .select("invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
    .order(total_revenue: :desc)
    .first
    .created_at
  end
>>>>>>> main
end
