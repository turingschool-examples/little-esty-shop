class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update(status: params[:invoice_status].to_i)
    # binding.pry
    redirect_to "/admin/invoices/#{@invoice.id}"
  end

end
