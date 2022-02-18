class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :transactions
  validates :customer_id, presence: true
  validates :status, presence: true

end
