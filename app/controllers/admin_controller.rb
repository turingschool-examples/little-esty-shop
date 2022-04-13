class AdminController < ApplicationController
  def index
    @customers = Customer.top_five_customers
    @invoices = Invoice.pending_invoices
  end

  def merchants
    @merchants = Merchant.all
  end

  def merchants_show
    @merchant = Merchant.find(params[:id])
  end

  def invoices
  end

  def invoices_show
    @invoice = Invoice.find(params[:id])
  end
end
