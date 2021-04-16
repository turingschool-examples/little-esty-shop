class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    binding.pry
    @merchant.items.create!(item_params)
    # item = @merchant.items.create!({
    #   name: params[:name],
    #   description: params[:description],
    #   unit_price: params[:unit_price],
    #   status: 0
    # })
    if item.save
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      redirect_to "/merchant/#{@merchant.id}/items/new"
    end
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    if params.include?(:item_status)
      if params[:item_status] == "disabled"
        item.update(status: 1)
        redirect_to "/merchant/#{merchant.id}/items"
      else
        item.update(status: 0)
        redirect_to "/merchant/#{merchant.id}/items"
      end
    elsif item.update(item_params)
      flash[:message] = "Item successfully updated #{error_message(item.errors)}"
      redirect_to "/merchant/#{merchant.id}/items/#{item.id}"
    else
      flash[:error] = "Please fill in all fields. #{error_message(item.errors)}."
      redirect_to "/merchant/#{merchant.id}/items/#{item.id}/edit"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id, :status)
  end
end
