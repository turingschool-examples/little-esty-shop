class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  validates :name, :description, :unit_price, presence: true

  def retrieve_invoice_id
    Invoice.joins({invoice_items: :item}).where(items: {id: self.id}).pluck(:id)
  end
end
