class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    new_id = Item.maximum(:id) + 1
    @merchant = Merchant.find(params[:merchant_id])
    item = @merchant.items.new(name: params[:name],
                               description: params[:description],
                               unit_price: params[:unit_price],
                               id: new_id)
    if item.save
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      flash[:notice] = "Required information missing"
      redirect_to "/merchants/#{@merchant.id}/items/new"
    end
  end

  def update
    item = Item.find(params[:id])
    if params[:true_update]
      item.update!(name: params[:name],
                   description: params[:description],
                   unit_price: params[:unit_price])

    redirect_to ("/merchants/#{params[:merchant_id]}/items/#{item.id}")
    else
      if item.status == "enabled"
        item.update(status: "disabled")
      else
        item.update(status: "enabled")
      end
    redirect_to ("/merchants/#{params[:merchant_id]}/items")
    end
  end
end
