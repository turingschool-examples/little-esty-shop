class Invoice < ApplicationRecord
  validates :status, presence: true, numericality: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
  validates :customer_id, presence: true
  has_many :invoice_items
  has_many :transactions
  belongs_to :customer
  has_many :items, through: :invoice_items

  enum status: [:cancelled, 'in progress', :completed]
end
