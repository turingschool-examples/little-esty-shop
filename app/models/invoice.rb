class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer

  enum status: {in_progress: 'In Progress', cancelled: 'Cancelled', completed: 'Completed'}
end
