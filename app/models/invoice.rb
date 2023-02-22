class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions

  enum status: ["in progress", "completed", "cancelled"]
end
