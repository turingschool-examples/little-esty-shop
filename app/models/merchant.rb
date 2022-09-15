class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items

  def merchant_invoices
    Invoice.joins(:items).where("items.merchant_id = ?", id)
  end
end



