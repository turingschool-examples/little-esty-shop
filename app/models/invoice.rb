class Invoice < ApplicationRecord
  belongs_to :customer
  enum status: {"in progress" => 0, completed: 1, cancelled: 2}
end
