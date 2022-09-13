class Invoice < ApplicationRecord
  has_many :transactions
  enum status: { cancelled: 0, 'in progress' => 1, completed: 2 }
end
