class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  belongs_to :merchant
	enum status: [ "enabled", "disabled" ]


  def self.enabled_items
    where(status: 0)
  end

  def self.disabled_items
    where(status: 1)
  end

  def find_item_invoice_by_merchant_id(merchant_id)
    # require 'pry'; binding.pry
  end
end
