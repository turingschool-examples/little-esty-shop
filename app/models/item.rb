class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  enum status: ["enabled", "disabled"]

  def top_selling_date
    invoices.joins(:transactions).
    where("transactions.result = 'success'").
    order("invoice_items.quantity desc, invoices.created_at").
    first.created_at
  end
end