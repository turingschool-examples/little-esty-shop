class Admin::InvoicesController < ApplicationController
  before_action :set_invoice, only: [ :show, :edit, :update ]

  def index
    @invoices = Invoice.all
    @pending_items = Item.items_ready_to_ship_by_ordered_date
  end

  def show

  end

  def edit

  end

  def new
  end

  def create
  end

  def update
    @invoice.update(status: params[:status] )
    @invoice.save
    redirect_to admin_invoice_path(@invoice)
    flash[:notice] = "Invoice status successfully updated!"
  end

  private

    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

end
