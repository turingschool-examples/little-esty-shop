class Invoice < ApplicationRecord
  enum status: { 'in progress' => 0, cancelled: 1, completed: 2 }
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  scope :with_successful_transactions, -> { joins(:transactions)
  .where("transactions.result =?", 0)}

  def customer_name
    customer = Customer.find(customer_id)
    customer.first_name + " " + customer.last_name
  end

  def invoice_revenue
    (invoice_items.sum("invoice_items.unit_price * invoice_items.quantity"))/100
  end

  def self.not_shipped
                joins(:invoice_items)
                .where("invoice_items.status != 2")
                .group(:id)
                .order(created_at: :asc)
                .distinct
  end
end
