class Invoice < ApplicationRecord
  has_many :items, through: :invoice_items
  enum status: ["in progress".to_sym, :completed, :cancelled]
end
