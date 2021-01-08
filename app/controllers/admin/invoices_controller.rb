class Admin::InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :update]

  def index
    @invoices = Invoice.all
  end

  def show
  end

  def update
    @invoice.update(invoice_params)
    flash[:success] = "Invoice successfully updated"
    redirect_to admin_invoice_path(@invoice)
  end

  private

  def invoice_params
    params.require(:invoice).permit(:quantity, :unit_price, :status)
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end
end