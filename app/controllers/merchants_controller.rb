class MerchantsController < ApplicationController
  def dashboard
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
    @merchant = Merchant.find(params[:id])
    @images = @image_search.images(@merchant.name)
  end
end