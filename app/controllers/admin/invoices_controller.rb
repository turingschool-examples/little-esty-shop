class Admin::InvoicesController < ApplicationController

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items_and_attributes = @invoice.items_with_invoice_attributes
    @total_revenue = @invoice.calc_total_revenue.first
    @statuses = ["cancelled", "in_progress", "completed"]
  end

  def index
    @invoices = Invoice.all
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.update(invoice_params)
    redirect_to 
  end

  private
  def invoice_params
    params.permit(:status)
  end
end