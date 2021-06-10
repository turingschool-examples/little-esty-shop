class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @disabled_items = @items.disable_items
    @enabled_items = @items.enable_items
    @top_items = @items.top_popular_items
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new({
      name: params[:name],
      description: params[:description],
      unit_price: params[:unit_price]
      })

    if @item.save!
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      flash[:alert] = "Error: #{@item.errors.full_messages.to_sentence}"
      render :new
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.update(item_params)

    if @item.save
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      flash[:notice] = "Item information has been successfully updated!"
    else
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
      flash[:alert] = "Error: #{@item.errors.full_messages.to_sentence}"
    end
  end

  def update_item_status
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.status = params[:status]

    if @item.save
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      flash[:alert] = "Error: #{@item.errors.full_messages.to_sentence}"
      redirect_to "/merchants/#{@merchant.id}/items"
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
