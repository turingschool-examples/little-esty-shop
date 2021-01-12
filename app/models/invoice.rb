class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions

  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:"in progress", :completed, :cancelled]

  def find_customer_name_for_merchant
    self.first_name + " " + self.last_name
  end

  def total_success
    self.most_success
  end
end
