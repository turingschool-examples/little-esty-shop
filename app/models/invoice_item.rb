class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates_presence_of :status
  belongs_to :invoice
  belongs_to :item

  has_many :transactions, through: :invoice

  enum status: ['pending', 'packaged', 'shipped']

  def self.find_invoice_items(params)
    joins(:item)
      .select('invoice_items.*, items.*')
      .where('invoice_id = ?', params)
  end

  def convert_to_dollar
    if unit_price.nil?
      0
    else
      unit_price.to_f / 100
    end
  end
end
