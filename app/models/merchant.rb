class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def enable
    self.update(status: true)
  end

  def disable
    self.update(status: false)
  end

  def self.group_by_enabled
    Merchant.where('status = ?', true)
  end

  def self.group_by_disabled
    Merchant.where('status = ?', false)
  end
end
