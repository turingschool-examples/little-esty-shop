class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  enum status: { "Disabled" => 0, "Enabled" => 1}

  def self.enabled
    where(status: 1)
  end

  def self.disabled
    where(status: 0)
  end

  def top_customers
    Customer.top_customers(self)
  end

  def shippable_items
    items.shippable_items
  end

  def invoice_ids
    items.joins(:invoices).distinct.pluck(:invoice_id)
  end
end
