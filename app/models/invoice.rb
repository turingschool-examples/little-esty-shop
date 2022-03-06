class Invoice < ApplicationRecord
  enum status: { 'in progress' => 0, cancelled: 1, completed: 2 }
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  scope :with_successful_transactions, -> { joins(:transactions)
  .where("transactions.result =?", 0)}

  def customer_name
    customer = Customer.find(customer_id)
    customer.first_name + " " + customer.last_name
  end

  def pre_discount_revenue
    cents = (invoice_items.sum("invoice_items.unit_price * invoice_items.quantity"))
    '%.2f' % (cents / 100.0)
  end

  def sucessful_transactions
    transactions.where('transactions.result =?', 0)
  end

  def merchant_discounts
    if self.sucessful_transactions.count > 0
    bulk_discounts.joins(merchant: :invoice_items)
    .select("bulk_discounts.*, bulk_discounts.merchant_id, bulk_discounts.name, bulk_discounts.percent_discount, bulk_discounts.quantity_threshold")
    .group("bulk_discounts.merchant_id, bulk_discounts.id")
    .order('bulk_discounts.merchant_id, bulk_discounts.quantity_threshold')
  end
end


    #
  # def discounted_revenue
  #   revenue = 0
  #   discounts = merchant_discounts
  #   self.invoice_items.each do |item|
  #     item.
  #
  #
  # end


  def display_date
    self.created_at.strftime("%A, %B %d, %Y")
  end

  def self.not_shipped
                  joins(:invoice_items)
                  .where("invoice_items.status != 2")
                  .group(:id)
                  .order(created_at: :asc)
                  .distinct
  end

end
