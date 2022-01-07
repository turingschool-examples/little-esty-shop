class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  enum status: %i[enabled disabled]

  def self.top_five
    select('items.*, sum(invoice_items.unit_price * invoice_items.quantity) as sum').order(sum: :desc).joins(:transactions, :invoice_items).where(:transactions => {result: 'success'}).group(:id).limit(5)
  end
end
