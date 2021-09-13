class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  enum status: {
    'in progress': 0,
    cancelled: 1,
    completed: 2,
  }
end
