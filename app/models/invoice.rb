class Invoice < ApplicationRecord
  validates_presence_of :customer_id, :merchant_id

  enum status: ['cancelled', 'completed', 'in progress']
  
  belongs_to :customer
  belongs_to :merchant
  
  has_many :transactions, dependent: :destroy
end
