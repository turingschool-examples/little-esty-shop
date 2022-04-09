class Invoice < ApplicationRecord
  belongs_to :customer

  enum status: {"cancelled" => 0, "in progress" => 1, "completed" => 2}
end
