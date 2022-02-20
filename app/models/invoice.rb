class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  belongs_to :customer
  validates_presence_of :status

  enum status: { "Cancelled" => 0, "In Progress" => 1, "Complete" => 2  }
end
