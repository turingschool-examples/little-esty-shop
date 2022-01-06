class Item < ApplicationRecord
  belongs_to(:merchant)
  has_many(:invoice_items)
  has_many(:invoices, through: :invoice_items)

  enum status: {"disabled" => 0, "enabled" => 1}

  def self.only_enabled
    where(status: 1)
  end

  def self.only_disabled
    where(status: 0)
  end

end
