class Invoice < ApplicationRecord
  belongs_to :customer

  enum status: {"pending" => 0, "packaged" => 1, "shipped" => 2}
end
