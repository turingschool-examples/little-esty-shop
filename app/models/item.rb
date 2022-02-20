class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true, numericality: true


  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  attribute :status, :integer, default: 2

  def display_price
    cents = self.unit_price
    '%.2f' % (cents /100.0)
  end

end
