class Invoice < ApplicationRecord
  enum status: { cancelled: 0, in_progress: 1, completed: 2 }

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  belongs_to :customer
end

