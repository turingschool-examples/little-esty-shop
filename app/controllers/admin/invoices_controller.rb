class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
    @pending_items = Item.items_ready_to_ship_by_ordered_date
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def new
  end

  def create
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update(status: params[:status] )
    @invoice.save
    redirect_to admin_invoice_path(@invoice)
    flash[:notice] = "Invoice status successfully updated!"
  end

end
