class InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
   
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.items_with_attributes
    @total_revenue = @invoice.calc_total_revenue
    @statuses = ["pending", "packaged", "shipped"]
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.update(item_invoice_params)
  end

  private
  def item_invoice_params
    params.permit(:status)
  end
end
