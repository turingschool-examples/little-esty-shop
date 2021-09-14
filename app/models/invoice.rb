class Invoice < ApplicationRecord
  self.primary_key = :id

  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy

  enum status: ['in progress', 'completed', 'cancelled']

  scope :for_merchant, ->(merchant) {
    joins(:items).where('items.merchant_id = ?', merchant.id).order(:created_at).distinct
  }
end
