class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
    @item_price = @item.unit_price
  end 

  def edit 
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if params[:commit] == 'Update'
      if item.update(item_params)
        flash[:notice] = 'Item updated successfully!'
        redirect_to merchant_item_path(item.merchant, item)
      else
        flash.now[:alert] = item.errors.full_messages
        render :edit
      end
    end
    if params[:button] == 'true' 
      if item.status == 'enabled'
      # item.status = 'disabled'
      item.update!(status: 'disabled')
      else
      # item.status = 'enabled'
      item.update!(status: 'enabled')
      end
      redirect_to "/merchants/#{item.merchant.id}/items"
    end
    # item.save
    
  end

  private 
  def item_params
  params.permit(:name, :description, :unit_price)
  end
end