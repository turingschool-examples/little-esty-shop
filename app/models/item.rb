class Item < ApplicationRecord
  validates :name, allow_blank: false, presence: true
  validates :description, allow_blank: false, presence: true
  validates :unit_price, allow_blank: false, presence: true
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def convert_date
    expected = invoices.first.created_at
    expected.strftime("%A, %B %d, %Y")
  end

  def disable_item
    update(status: false)
  end

  def enable_item
    update(status: true)
  end
end
