class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  enum status: {"cancelled" => 0, "in progress" => 1, "completed" => 2}
end
