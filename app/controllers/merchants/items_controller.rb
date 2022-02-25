class Merchants::ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:item_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:item_id])
  end

  def update
    item = Item.find(params[:item_id])

    if params[:mode] == "form"

      item.update(item_params)
      flash[:alert] = "Item successfully updated!"
      redirect_to "/merchants/#{params[:merchant_id]}/items/#{item.id}"

    elsif params[:mode] == "button"
      
      item.update({ status: params[:status] })
      redirect_to "/merchants/#{params[:merchant_id]}/items"
      flash[:alert] = "Item status updated!"
    end
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def create
    merchant = Merchant.find(params[:id])
    item = merchant.items.create(item_params)

    if item.save
      redirect_to "/merchants/#{params[:id]}/items"
    else
      redirect_to "/merchants/#{params[:id]}/items/new"
      flash[:alert] = "Error: #{error_message(item.errors)}"
    end
  end

    private
      def item_params
        params.permit(:name, :description, :unit_price)
      end
end
