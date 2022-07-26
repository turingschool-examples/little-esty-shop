class Invoice < ApplicationRecord
  validates_presence_of :status
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: { 'in progress' => 0, 'cancelled' => 1, 'completed' => 2 }
end
