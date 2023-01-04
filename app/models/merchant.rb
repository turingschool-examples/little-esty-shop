class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items

  validates_presence_of :name

  def all_invoice_ids
    self.invoice_items.pluck(:invoice_id).uniq
  end
end