class Merchant::DashboardController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    @items_not_yet_shipped = @merchant.invoice_items.not_yet_shipped
    @photo = PhotoBuilder.merchant_photo_info
  end
end