class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
    @customer = Customer.find(@invoice.customer_id)
    @invoice_items = InvoiceItem.find_invoice_items(@invoice)
    @invoice_revenue = Invoice.expected_invoice_revenue(@invoice)[0].invoice_revenue.to_f / 100
  end
end
