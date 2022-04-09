class Invoice < ApplicationRecord
  validates :status, presence:true
  

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer

  enum status: { cancelled: 0,  "in progress"  => 1, completed: 2 }
end
