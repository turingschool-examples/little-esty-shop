class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :item_status, presence: true, numericality: true

  attribute :item_status, :integer, default: 2

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices


  def display_price
    cents = self.unit_price
    '%.2f' % (cents /100.0)
  end

end
