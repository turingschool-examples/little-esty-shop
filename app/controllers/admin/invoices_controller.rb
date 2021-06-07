class Admin::InvoicesController < ApplicationController
  before_action :load_data, only: [:show, :update]

  def index
    @invoices = Invoice.all
  end

  def show
    # @invoice = Invoice.find(params[:invoice_id])
    # @customer = Customer.find(@invoice.customer_id)
    # @invoice_items = InvoiceItem.find_invoice_items(@invoice.id)
    # @invoice_revenue = Invoice.expected_invoice_revenue(@invoice)[0].invoice_revenue.to_f / 100
  end

  def update
    # @invoice = Invoice.find(params[:invoice_id])
    # @customer = Customer.find(@invoice.customer_id)
    # @invoice_items = InvoiceItem.find_invoice_items(@invoice.id)
    # @invoice_revenue = Invoice.expected_invoice_revenue(@invoice)[0].invoice_revenue.to_f / 100
    @invoice.update(status: params[:status])
    # binding.pry
    @invoice.save!
    redirect_to "/admin/invoices/#{@invoice.id}"
    # render :show
  end

  private

  def load_data
    @invoice = Invoice.find(params[:invoice_id])
    @customer = Customer.find(@invoice.customer_id)
    @invoice_items = InvoiceItem.find_invoice_items(@invoice.id)
    @invoice_revenue = Invoice.expected_invoice_revenue(@invoice)[0].invoice_revenue.to_f / 100
  end
end
