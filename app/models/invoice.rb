class Invoice < ApplicationRecord
  belongs_to :customer

  enum status: {'in progress' => 0, 'cancelled' => 1, 'completed' => 2}
end
