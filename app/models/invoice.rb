class Invoice < ApplicationRecord
  belongs_to :customer

  enum status: {'In Progress' => 0, 'Cancelled' => 1, 'Completed' => 2}
end
