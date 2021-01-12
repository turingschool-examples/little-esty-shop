class ItemsController < ApplicationController

  def index
    @item = Item.all
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.create(item_params)
    if @item.id
      redirect_to "/merchant/#{@merchant.id}/items"
    else
      flash[:notice] = @item.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
    if @item.update(item_params)
      redirect_to "/merchant/#{@merchant.id}/items/#{@item.id}", notice: "Update Successful"
    else
      flash[:notice] = @item.errors.full_messages.to_sentence
      render :edit
    end
  end

  private
  def item_params
    params.permit(:description, :unit_price, :name, :merchant_id)
  end
end
