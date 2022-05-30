class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name

  def merchant_ii
    Merchant.find(self.invoice_item)
  end
end
