class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true


  def merchant_invoices
    Invoice.joins(:items).where("items.merchant_id = ?", id)
  end

  def enabled
    items.where(status: 1)
  end

  def disabled
    items.where(status: 0)
  end
end
