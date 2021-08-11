class Discount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :percentage, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100 }
  validates :threshold, presence: true, numericality: { only_integer: true, greater_than: 0 }

end
