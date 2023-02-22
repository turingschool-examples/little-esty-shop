class Invoice < ApplicationRecord
  belongs_to :customer
  enum staus: ["in progress","cancelled", "completed"]
end
