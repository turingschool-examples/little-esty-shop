class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

	def show
		@merchant = Merchant.find(params[:merchant_id])
		@item = @merchant.items.find(params[:item_id])
	end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

	def edit
		@merchant = Merchant.find(params[:merchant_id])
		@item = @merchant.items.find(params[:item_id])
	end

  def create
		@merchant = Merchant.find(params[:merchant_id])
    @item = Item.new(item_params)
    
    if @item.save
      @merchant.items.create!(item_params)
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      flash[:notice] = "Item not created: Required information missing"
      redirect_to "/merchants/#{@merchant.id}/items/new"
    end
  end

	def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:item_id])
		if params[:status] == "disabled"
      @item.update(status: 1)
      redirect_to "/merchants/#{@merchant.id}/items"
    elsif params[:status] == "enabled"
      @item.update(status: 0)
      redirect_to "/merchants/#{@merchant.id}/items"
		elsif @item.update(item_params)
			flash[:success] = "Item updated successfully"
    	redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
		else
    	redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
  	end
	end
  

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end