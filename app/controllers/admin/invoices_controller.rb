class Admin::InvoicesController < ApplicationController
  def show 
    @invoice = Invoice.find(params[:id])

  end

  def update 
    @invoice = Invoice.find(params[:id])
    if params[:status]
      @invoice = Invoice.update(status: params[:status]) 
      redirect_to admin_invoice_path(@invoice)
    end
  end
end