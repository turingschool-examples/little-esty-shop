class Invoice < ApplicationRecord
  validates :status, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer
end
