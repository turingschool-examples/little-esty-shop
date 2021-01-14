class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions

  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:"in progress", :completed, :cancelled]

  def self.incomplete
    joins(:invoice_items)
    .where('invoices.status = ? AND invoice_items.status != ?', 0, 2)
    .select("invoices.*, COUNT('invoice_items.status') AS item_count")
    .group(:id)
  end

  def clean_date
    created_at.strftime("%A, %B %m, %Y")
  end

  def find_customer_name_for_merchant
    self.first_name + " " + self.last_name
  end

  def total_success
    self.most_success
  end

  def find_customer_on_invoice
    customer = Customer.joins(:invoices).where('invoices.id = ?', self.id).select(:first_name, :last_name).first
    "#{customer.first_name} #{customer.last_name}"
  end

  def find_items_on_invoice
    Item.joins(:invoices).where('invoices.id = ?', self.id).select('items.*')
  end

  def find_invoice_item_data_for_item(item)
    InvoiceItem.where(item_id: item.id).where(invoice_id: self.id).first
  end
end
