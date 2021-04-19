class Merchant::ItemsController < ApplicationController
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

  def update
    item = Item.find(params[:id])
    item.update(item_params)

    if params.include?(:enabled)
        if item.enabled == true
          item.update(enabled: false)
          redirect_to "/merchants/#{item.merchant_id}/items"
        else item.enabled == false
          item.update(enabled: true)
          redirect_to "/merchants/#{item.merchant_id}/items"
        end
    else
       item.save
        flash[:success] = "You updated the item!"
        redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @merchant.items.create!(name: params[:item][:name],
                description: params[:item][:description],
                unit_price: params[:item][:unit_price],
                id: find_new_id, merchant: @merchant)
    redirect_to merchant_items_path(@merchant)
  end


  private
  def item_params
    params.fetch(:item, {}).permit(:name, :description, :unit_price, :enabled)
  end

  def find_new_id
    Item.last.id + 1
  end
end
