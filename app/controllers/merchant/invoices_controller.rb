class Merchant::InvoicesController < ApplicationController
  before_action :set_merchant, only: [ :show, :update ]
  before_action :set_invoice, only: [ :show, :update, :destroy ]

  def index
    @invoices = Merchant.merchant_invoices(params[:merchant_id])
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
    @invoice_item = InvoiceItem.find(params[:ii_id])
    @invoice_item.update(status: params[:status])
    @invoice_item.save

    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    flash[:notice] = "Item status successfully updated!"
  end

  private

    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def set_merchant
      @merchant = Merchant.find(params[:merchant_id])
    end
end
