class Invoice < ApplicationRecord
  validates_presence_of :status, :customer_id, :merchant_id
  
  belongs_to :customer
  belongs_to :merchant
  
  has_many :transactions, dependent: :destroy
end
