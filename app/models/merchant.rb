class Merchant < ApplicationRecord
  has_many :items

  validates :name, presence: true

  def invoice_finder
    Invoice.joins(:invoice_items => :item).where(:items => {:merchant_id => self.id})
  end
end
