class Invoice < ApplicationRecord
  validates_presence_of :status, presence: true, numericality: true

  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  enum status: { "in progress": 0, "completed": 1, "cancelled":2 }
end
