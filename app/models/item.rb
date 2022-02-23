class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true
  enum status: { enabled: 0, disabled: 1 }

  def invoice_items_by_id(invoice_id)
    invoice_items
      .select('invoice_items.*')
      .where('invoice_id = ?', invoice_id)
  end

  def self.enabled_items
    where(status: 0)
  end

  def self.disabled_items
    where(status: 1)
  end
  
end
