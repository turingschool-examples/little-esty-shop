class Merchants::ItemsController < ApplicationController

  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @items_for_specific_merchant = @merchant.items
    @items_with_disabled_status = Item.all.disabled_status_items(params)
    @items_with_enabled_status = Item.all.enabled_status_items(params)
    @five_popular_items = @merchant.items.select('items.*, SUM(invoice_items.unit_price* invoice_items.quantity) as revenue_generated').joins(:transactions).where(transactions: {result: "success"}).joins(:invoice_items).group(:id).order('revenue_generated DESC').limit(5)

  end

  def show
    @items = Item.all
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
end