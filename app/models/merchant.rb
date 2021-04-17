class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy

####### dashboard methods #########

  def top_five_customers
    Merchant.joins(items: {invoice_items: {invoice: {transactions: {invoice: :customer}}}})
        .where("merchants.id = ?", self.id).where("result = ?", 1).limit(5)
        .group('customers.id', 'customers.first_name', 'customers.last_name').order(count: :desc).count
  end

  def ship_ready
    Merchant.joins(items: {invoice_items: :invoice})
      .where("merchants.id = ?", self.id).where("invoices.status != ?", 1).where("invoice_items.status != ?", 2)
      .order("invoices.created_at").pluck("items.name", "invoices.id", "invoices.created_at")
  end


####### item methods ##############









###### invoice methods ###########

end
