class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items

  validates_presence_of :name

  enum status: { enabled: 0, disabled: 1 }

  def all_invoice_ids
    self.invoice_items.pluck(:invoice_id).uniq
  end

  def toggle_status
    self.status == "enabled" ? self.status = "disabled" : self.status = "enabled"
  end
end