class Invoice < ApplicationRecord
  validates :status, presence: true
  enum status: [ 'in progress', 'cancelled', 'completed' ]

  belongs_to :customer

  has_many :transactions, dependent: :destroy
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.find_all_invoices_not_shipped
    joins(:invoice_items)
    .where.not("invoice_items.status = ?", 2)
    .order(created_at: :desc)
    .distinct
  end

  def item_sell_info
    self.invoice_items.includes(:item)
  end
end
