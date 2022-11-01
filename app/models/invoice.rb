class Invoice < ApplicationRecord
  belongs_to :customer
  enum status: ["in progress", "cancelled", "completed"]
end
