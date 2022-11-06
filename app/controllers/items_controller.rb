class ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @enabled_items = @merchant.items.where(status: 1)
      @disabled_items = @merchant.items.where(status: 0)
    else
      @items = Item.all
    end
  end

  def show
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @item = @merchant.items.find(params[:id])
    else
      @item = Item.find(params[:id])
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
    if @item.update(item_params)
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      flash[:message] = 'Information successfully updated'
    else
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
      flash[:error] = 'Required content missing or unit price is invalid'
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new(name: params[:name],
                                description: params[:description],
                                unit_price: params[:unit_price])

    if @item.save
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      flash[:error] = 'Required content missing or unit price is invalid'
      redirect_to "/merchants/#{@merchant.id}/items/new"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
