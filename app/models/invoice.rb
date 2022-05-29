class Invoice < ApplicationRecord
  enum status: { 'in progress' => 0, 'cancelled' => 1, 'completed' => 2 }

  belongs_to :customer
  has_many :transactions
  validates_presence_of :status

end
