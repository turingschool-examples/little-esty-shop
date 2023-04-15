class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :transactions, through: :invoices

  enum status: ["pending", "packaged", "shipped"]

  def self.not_yet_shipped
    joins(:invoice).where.not(status: 2).order('invoices.created_at')
  end

  def item_name
    item.name
  end
end