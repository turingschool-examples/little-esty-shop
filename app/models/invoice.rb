class Invoice < ApplicationRecord
  validates :status, presence: true  #is string, but should be integer status?

  belongs_to :customer

  has_many :invoice_items
  has_many :items, through: :invoice_items
end
