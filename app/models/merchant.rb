class Merchant < ApplicationRecord
  enum status: { :disabled => 0, :enabled => 1}, _prefix: true

  has_many :items
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.disabled
    where(status: 0)
  end

  def self.enabled
    where(status: 1)
  end
end
