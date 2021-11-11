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

  def update
    @item = Item.find(params[:id])
    @merchant = @item.merchant
    @item.update(status: params[:disable].to_i) if params[:disable]
    @item.update(status: params[:enable].to_i) if params[:enable]
    if @item.update(item_params)
      flash[:success] = 'Successfully Updated'
      redirection 
      # redirect_to merchant_item_path(@merchant)
    else
      flash[:alert] = 'Try Again'
      redirect_to edit_merchant_item_path(@merchant, @item) #need this
      end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.new(item_params)

    if item.save
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      redirect_to "/merchants/#{@merchant.id}/items/new"
      #put a flash here
    end
  end
end

private
def item_params
  params.permit(:id, :name, :description, :unit_price, :merchant_id, :status)
end

def redirection
  if params[:disable] || params[:enable]
    redirect_to merchant_items_path(@merchant)
  else
  redirect_to merchant_item_path(@merchant, @item)
  end
end
