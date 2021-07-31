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
  end

end
