class Invoice < ApplicationRecord
  validates_presence_of :status
  validates_presence_of :customer_id

  belongs_to :customer
  has_many :merchants, through: :items
  has_many :transactions
  has_many :invoice_items

  enum status: {"In Progress" => 0, "Completed" => 1, "Cancelled" => 2}
end
