class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  validates_presence_of :first_name, :last_name 

  def successful_transactions_with_merchant(merch)
    merchant_items = Item.where(merchant_id: merch.id)
    customer_merchant_invoices = Invoice.joins(:items).where(items: { id: merchant_items }).where(customer_id: id).distinct
    # customer_merchant_invoice_ds = Customer.joins(:invoices).where(invoices: { id: merchant_invoices }).where(id: id)
    successful_transactions = Invoice.joins(:transactions).where(id: customer_merchant_invoices).where(transactions: { result: "success" }).count
    # binding.pry
  end
end