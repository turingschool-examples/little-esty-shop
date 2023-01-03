class Invoice < ApplicationRecord
  belongs_to :customer 
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  
  validates_presence_of :status

  enum status: {cancelled: 0,
                completed: 1,
                in_progress: 2}
end