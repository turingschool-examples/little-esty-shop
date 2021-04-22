class MerchantsController < ApplicationController

  def welcome
  end

  def show
    @merchant = Merchant.find(params[:id])
    @top_five = @merchant.top_five_customers
    @ship_ready = @merchant.ship_ready
  end

  def index
    @merchants = Merchant.all
  end

  def item_index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items.all
  end

  def item_show
  end

  def invoice_index
    @merchant = Merchant.find(params[:id])
    @invoices = @merchant.unique_invoices
    # @invoices = Invoice.joins(items: :merchant).where('merchants.id = ?', @merchant.id).group(:id)
  end

  def invoice_show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:invoice_id])
    @customer = Customer.find(@invoice.customer_id)
    @items = @invoice.invoice_items_info(@merchant.id)
    @total_revenue = @invoice.expected_revenue(@merchant.id)
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice = Invoice.find(params[:invoice_id])
    invoice.update(invoice_params)
    redirect_to "/merchants/#{merchant.id}/invoices/#{invoice.id}"
  end

  def invoice_params
    params.permit(:id, :status, :customer_id)
  end



end
