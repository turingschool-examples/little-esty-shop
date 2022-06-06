class AdminInvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.status = params[:status]
    invoice.save
    redirect_to "/admin/invoices/#{invoice.id}"
  end
  

end
