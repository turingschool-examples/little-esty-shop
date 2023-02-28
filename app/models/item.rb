class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy
  has_many :customers, through: :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy
  

  enum status: [:disabled, :enabled]

  validates :name, :description, :unit_price, presence: :true

  def item_best_day
    invoices.where('invoices.status = 1')
      .select('invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
      .group('invoices.created_at')
      .order("revenue desc", "invoices.created_at desc")
      .first
  end
end
