class Invoice < ApplicationRecord
  belongs_to :customer
  # validates :customer_id, presence: true
end
