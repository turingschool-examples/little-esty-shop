class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  enum active_status: { enabled: 0, disabled: 1 }

  def self.active
    where(active_status: :enabled)
  end

  def self.inactive
    where(active_status: :disabled)
  end
end
