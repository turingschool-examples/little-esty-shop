class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update 
    invoice = Invoice.find(params[:id])
    invoice.update(invoice_params)
    if (params[:invoice][:status] == "in_progress")
      invoice.update(status: 0)
    elsif (params[:invoice][:status] == "completed")
      invoice.update(status: 1)
    elsif (params[:invoice][:status] == "cancelled")
      invoice.update(status: 2)
    end
    flash[:alert] = "Information Successfully Updated!"
    redirect_to admin_invoice_path(invoice)
  end

  private 
  def invoice_params
    params.require(:invoice).permit(:status)
  end
end