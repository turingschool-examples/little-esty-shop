class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  # enum status: [:disabled, :enabled]
  def self.enable
    where(status: true)
  end

  def self.disable
    where(status: false)
  end

  def enable_merchant
    update(status: true)
  end

  def disable_merchant
    update(status: false)
  end


  def invoice_items_ready_to_ship
    invoice_items.where.not(status: :shipped)
   .joins(:invoice)
   .where('invoices.status = ?', Invoice.statuses[:completed])
   .order('invoices.created_at')
  end
end
