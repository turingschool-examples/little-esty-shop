class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy

  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
    
  enum status: { in_progress: 0, completed: 1, cancelled: 2 }

  def self.incomplete
    where(status: 'in progress').or(where(status: 'cancelled'))
  end
end
