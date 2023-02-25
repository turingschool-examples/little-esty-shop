class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  
  enum status: [ :in_progress, :completed, :cancelled ]


  def self.incomplete
    joins(:invoice_items)
    .where("invoice_items.status != ?", 2) 
    # question mark is a placeholder for 2
  end
end
