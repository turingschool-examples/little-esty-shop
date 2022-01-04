class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  validates :status, presence: true
  # enum status: { pending: 0, approved: 1}
end
