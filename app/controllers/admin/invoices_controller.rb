class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = @invoice.customer
    @items = @invoice.items
  end

  def update
    @invoice = Invoice.find(params[:id])

    if params[:status]['cancelled']
      @invoice.update(status: 0)
    elsif params[:status]['completed']
      @invoice.update(status: 1)
    elsif params[:status]['in progress']
      @invoice.update(status: 2)
    end

    redirect_to admin_invoice_path(params[:id])
  end
end
