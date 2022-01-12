class ItemsController < ApplicationController
  before_action :do_merchant, except:[:update, :destroy]

  def index
    @items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    flash[:success] = 'Item successfully updated'
    redirect_to(merchant_item_path)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def new
  end

  def create
    item = Item.new(item_params)
    redirect_to merchant_items_path(@merchant) if item.save
  end

    private

      def item_params
        params.permit(:id, :name, :description, :unit_price, :merchant_id, :status)
      end
end
