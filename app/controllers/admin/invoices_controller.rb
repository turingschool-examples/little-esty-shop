class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
  end

  def show
    @invoice = Invoice.find(params[:id])
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
  end

  def update
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
    invoice = Invoice.find(params[:id])
    invoice.update(invoice_params)
    redirect_to admin_invoice_path(invoice)
  end

  private
  def invoice_params
    params.permit(:status)
  end
end