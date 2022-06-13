class BulkDiscount < ApplicationRecord
  validates :name, presence: true
  validates :percent_discount, presence: true, numericality: true
  validates :quantity_threshold, presence: true, numericality: true

  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def display_discount
    (percent_discount * 100).round
  end
end
