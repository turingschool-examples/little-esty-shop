class Invoice < ApplicationRecord
  enum status: { 'in progress' => 0, 'cancelled' => 1, 'completed' => 2 }

  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  validates_presence_of :status

end
