class Admin::InvoicesController < ApplicationController
  def show 
  @invoice = Invoice.find(params[:id])

  end

  def edit 
  end
  

  def update 
    @invoice = Invoice.find(params[:id])
    @invoice.update(status: params[:status]) 
    redirect_to admin_invoice_path(@invoice)
  
  end
end