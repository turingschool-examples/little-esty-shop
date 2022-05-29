class ItemsController < ApplicationController
  
  def index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
  end

  def show 
    
  end
end