class Invoice < ApplicationRecord
  enum status: ["cancelled", "in progress", "completed"]
end
