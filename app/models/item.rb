class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy
  has_many :customers, through: :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy
  

  enum status: [:disabled, :enabled]

  validates :name, :description, :unit_price, presence: :true

  def best_day
    invoices.order(:quantity).select('invoices.created_at, invoice_items.quantity').order(:quantity).last.created_at
  end
end
