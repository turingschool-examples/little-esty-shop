class Invoice < ApplicationRecord
  enum status: { "in progress" => 0, "canceled" => 1, "completed" => 2 }

  belongs_to :customer 
  validates_presence_of :status 
end
