class Invoice < ApplicationRecord

  enum status: {in_progress: 0, completed: 1, cancelled: 2}
  validates_presence_of :status
  validates_presence_of :customer_id

  belongs_to :customer
  has_many :transactions

  has_many :invoice_items
  has_many :items, through: :invoice_items
end
