class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    # @top_items = @merchant.items.select("items.*, unit_price * count(*) AS revenue").joins(:invoice_items).group("items.id").order("unit_price * count(*) desc").limit(5)
    @enabled_items = @items.enabled_items
    @disabled_items = @items.disabled_items
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    if @item.update(item_params)
      if params[:status] == "Enable"
        @item.status_update(1)      
        redirect_to "/merchants/#{@merchant.id}/items/"
      elsif params[:status] == "Disable"
        @item.status_update(0)      
        redirect_to "/merchants/#{@merchant.id}/items/"
      else
        redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      end
      flash[:alert] = "Information Successfully Updated!"
    else
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
      flash[:alert] = "Error: #{error_message(@item.errors)}"
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    item = Item.new(item_params)
    item.save
    redirect_to "/merchants/#{item_params[:merchant_id]}/items"
  end
  
  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id)
  end
end