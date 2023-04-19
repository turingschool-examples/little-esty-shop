class MerchantsController < ApplicationController
  def dashboard
    @merchant = Merchant.find(params[:id])
    @image_search = ImageSearch.new
    @images = @image_search.images(@merchant.name)
  end
end