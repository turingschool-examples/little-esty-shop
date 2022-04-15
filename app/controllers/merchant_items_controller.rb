class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
  end

  def update
    @item = Item.find(params[:id])

    if params[:status]
      @item.status = params[:status]
      @item.save
      redirect_to merchant_items_path

    else
      @item.update(item_params)
      redirect_to merchant_item_path, notice: "Update Successful"
    end
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @merchant.items.create(name: params[:name],
                           description: params[:description],
                           unit_price: params[:unit_price],
                           status: 0
                          )
    redirect_to merchant_items_path
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  private
    def item_params
      params.permit(:name, :description, :unit_price)
    end
end
