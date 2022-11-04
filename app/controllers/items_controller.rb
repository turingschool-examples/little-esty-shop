class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items
    @merchant_top_items = @merchant.top_5_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item_price = @item.unit_price
  end 

  def edit 
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    edit_form_submission
    enable_disable_toggle
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new(item_params)
    @item.save
    redirect_to "/merchants/#{@merchant.id}/items"
  end

  def edit_form_submission
    if params[:commit] == 'Update'
      if @item.update(item_params)
        flash[:notice] = 'Item updated successfully!'
        redirect_to merchant_item_path(@item.merchant, @item)
      else
        flash.now[:alert] = @item.errors.full_messages
        render :edit
      end
    end
  end

  def enable_disable_toggle
    if params[:button] == 'true' 
      if @item.status == 'enabled'
        @item.update!(status: 'disabled')
      else
        @item.update!(status: 'enabled')
      end
      redirect_to "/merchants/#{@item.merchant.id}/items"
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end

end