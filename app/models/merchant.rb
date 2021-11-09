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
    Customer.joins(invoices: [{ invoice_items: [{ item: :merchant }] }, :transactions])
    .where("transactions.result = 'success' AND merchants.id = '#{self.id}'")
    .group(:id)
    .order("transactions.count DESC")
    .first(5)
  end

  def shippable_items
    # items.select("items.*, invoice_items.invoice_id AS invoice_id, invoices.created_at AS invoice_created_at")
    #      .joins(:invoices)
    #      .where("invoice_items.status = '0'")
    #      .order('invoices.created_at')

   items.joins(:invoices)
        .select("items.*, invoice_items.invoice_id as invoice_id")
        .select("invoices.created_at AS invoice_created_at")
        .where("invoice_items.status = '0'")
        .order('invoices.created_at')
  end

  def invoice_ids
    items.joins(:invoices).distinct.pluck(:invoice_id)
  end
end
