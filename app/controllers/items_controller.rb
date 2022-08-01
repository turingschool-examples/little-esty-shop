class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
    # @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
      item = Item.find(params[:id])
      if item.update(item_params)

        if params[:status].present?
          redirect_to merchant_items_path(item.merchant)
          flash[:success] = "Item successfully updated!"
        else
          redirect_to merchant_item_path(item.merchant, item)
          flash[:success] = "Item successfully updated!"
        end

        else
          redirect_to edit_merchant_item_path(item.merchant, item)
          flash[:alert] = "Error: #{error_message(item.errors)}"
        end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
      merchant = Merchant.find(params[:merchant_id])
      item = merchant.items.new(name: params[:name], description: params[:description], unit_price: params[:unit_price], created_at: Time.now, updated_at: Time.now)
      if item.save
          redirect_to "/merchants/#{merchant.id}/items"
      else
          redirect_to "/merchants/#{merchant.id}/items/new"
          flash[:alert] = "Error: Please fill out all required fields!"
      end

  end


  private
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end
