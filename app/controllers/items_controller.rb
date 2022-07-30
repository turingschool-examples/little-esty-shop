class ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def create
    item = Item.new(name: params[:name], description: params[:description],unit_price: params[:unit_price], merchant_id: params[:id], status: 1)
    if item.save
      redirect_to "/merchants/#{item.merchant_id}/items"
    else
      redirect_to "/merchants/#{item.merchant.id}/items/new"
      flash[:alert] = "Error: #{error_message(item.errors)}" 
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to "/merchants/#{item.merchant.id}/items/#{item.id}"
      flash[:alert] = "Success: Item information successfully updated"
    else
      redirect_to "/merchants/#{item.merchant.id}/items/#{item.id}/edit"
      flash[:alert] = "Error: #{error_message(item.errors)}"
    end
  end

  def status
    item = Item.find(params[:id])
      if item.status == "enabled"
        item.update(status: "disabled")
        redirect_to "/merchants/#{item.merchant.id}/items"
        flash[:alert] = "#{item.name} has been disabled."
      else
        item.update(status: "enabled")
        redirect_to "/merchants/#{item.merchant.id}/items"
        flash[:alert] = "#{item.name} has been enabled."
      end 
  end
  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end