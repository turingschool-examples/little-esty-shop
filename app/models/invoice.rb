class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions

  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:"in progress", :completed, :cancelled]

  def all_successful_transactions
    Transaction.all_successful_transactions.where("invoice_id = ?", self.id)
  end

  def self.with_more_than_one_successful_transaction
    binding.pry
    where()


  def self.incomplete
    joins(:invoice_items)
    .where('invoices.status = ? AND invoice_items.status != ?', 0, 2)
    .select("invoices.*, COUNT('invoice_items.status') AS item_count")
    .group(:id)
  end

  def clean_date
    created_at.strftime("%A, %B %m, %Y")
  end

  def find_customer_name_for_merchant
    self.first_name + " " + self.last_name
  end

  def total_success
    self.most_success
  end
end
