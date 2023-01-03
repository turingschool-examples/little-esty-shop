class Invoice < ApplicationRecord
  belongs_to :customer
  
  enum status: ['in progress', 'completed', 'cancelled']
end
