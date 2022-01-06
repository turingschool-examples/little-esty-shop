class MerchantItemsController < ApplicationController

  def index
    @items = Item.where(merchant_id: params[:merchant_id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def update
    item = Item.find(params[:item_id])

    item.update(item_params)

    if params[:status].present?
      redirect_to action: :index
    else
      flash[:message] = 'changes saved successfully'
      redirect_to action: :show
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    Item.create(name: params[:name], description: params[:description], unit_price: params[:unit_price], status: 'disabled', merchant_id: params[:merchant_id])
    redirect_to action: :index
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end

end
