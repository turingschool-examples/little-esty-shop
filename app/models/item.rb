class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  enum status: {
    enabled: 0,
    disabled: 1
   }

  def create
  end

  def revenue_formatted
    '%.2f' % (revenue_per / 100)
  end

end
