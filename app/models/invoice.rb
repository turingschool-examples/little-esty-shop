class Invoice < ApplicationRecord
  enum status: { 'in progress' => 0, cancelled: 1, completed: 2 }
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def customer_name
    customer = Customer.find(customer_id)
    customer.first_name + " " + customer.last_name
  end

  def invoice_revenue
    (invoice_items.sum("invoice_items.unit_price * invoice_items.quantity"))/100
  end

  # def self.not_shipped
  #   # invoice_items = InvoiceItem.all
  #   Invoice.select("invoices.status, invoices.created_at AS created_at")
  #               .joins(:invoice_items)
  #               .where("invoice_items.status != 2")
  #               # .where(invoice.id: self.id)
  #               # require "pry"; binding.pry
  #               .group(:id)
  #               .order(created_at: :asc)
  #               .distinct
  # end

  def self.not_shipped
    # invoice_items = InvoiceItem.all
    # Invoice.select("invoices.status, invoices.created_at AS created_at")
                joins(:invoice_items)
                .where("invoice_items.status != 2")
                # .where(invoice.id: self.id)
                .group(:id)
                .order(created_at: :asc)
                .distinct
  end


  # def not_shipped
  #   invoice_ids = InvoiceItem.where("status != 2")
  #   # .pluck(:invoice_id)
  #   # invoice_items.where("status != 2")
  # end

  # def self.not_shipped
  #   invoice_ids = self.where.not(status: 1).pluck(:id)
  #   InvoiceItem.where.not(status: "shipped").where(invoice_id: invoice_ids).order(created_at: :asc)
  # end


end
