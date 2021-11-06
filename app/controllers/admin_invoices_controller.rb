class AdminInvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
    @customer = Customer.find(@invoice.customer_id)
    @invoice_items = InvoiceItem.find(params[:invoice_id])
    @item = Item.find(@invoice_items.item_id)
  end

  def update
    invoice = Invoice.find(params[:invoice_id])
    invoice.update(invoice_params)
    require "pry"; binding.pry
    redirect_to "/admin/invoices/#{invoice.id}"
  end


  private

    def invoice_params
      params.permit(:status, :name, :updated_at)
    end
end
