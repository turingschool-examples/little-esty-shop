class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  enum enabled: {enabled: 0, disabled: 1}

  def self.not_yet_shipped
    Item.joins(:invoices).select("items.name, invoices.id as invoice_id, invoices.created_at as invoice_date").where.not(invoice_items: {status: "shipped"}).order("invoice_date desc").as_json(:except => :id)
  end
end
