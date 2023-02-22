class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  #OR does one invoice belong to ONE transations??

  enum status: ["in progress", "completed", "cancelled"]
end
