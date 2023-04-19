class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @top_items = @merchant.top_5_items
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    @item_img = PhotoBuilder.item_img(@item.name)
  end
  
  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    if @item.update(item_params)
      if params[:item].nil? && params[:status] == "Enable"  
        @item.status_update(1)      
        redirect_to "/merchants/#{@merchant.id}/items/"
      elsif params[:item].nil? && params[:status] == "Disable" 
        @item.status_update(0)      
        redirect_to "/merchants/#{@merchant.id}/items/"
      elsif !params[:item].nil? && params[:item][:status] == "enabled"
        @item.status_update(1)
        redirect_to merchant_invoice_path(@merchant, params[:item][:invoice])
      elsif !params[:item].nil? && params[:item][:status] == "disabled" 
        @item.status_update(0)
        redirect_to merchant_invoice_path(@merchant, params[:item][:invoice])
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