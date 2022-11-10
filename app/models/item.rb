class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  enum status: [ :disabled, :enabled ]

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  def top_selling_date
    invoices
    .where("invoices.status = ?", 2)
    .select('invoices.*, sum(quantity * invoice_items.unit_price) as sum_id')
    .group(:id)
    .order('sum_id desc')
    .first
    .updated_at
  end
end
