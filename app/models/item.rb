class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true

  def self.enable
    where(enabled: true)
  end

  def self.disable
    where(enabled: false)
  end
end
