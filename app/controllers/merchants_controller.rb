class MerchantsController < ApplicationController
  def new_item
    @merchant = Merchant.find(params[:id])
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def item_index
    @merchant = Merchant.find(params[:id])
    @items = Item.where("merchant_id = #{@merchant.id}")
  end

  def invoice_index
    @merchant = Merchant.find(params[:id])
    @invoices = Invoice.find_invs_by_merchant(@merchant.id)
  end
end
