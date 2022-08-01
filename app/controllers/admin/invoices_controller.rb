class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:invoice_id])
    @invoice.update!(invoice_status)
    redirect_to "/admin/invoices/#{params[:invoice_id]}"
  end
  
  private 
  def invoice_status
    params.permit(:status)
  end
end
