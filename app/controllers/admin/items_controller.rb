# app/controllers/item_controller.rb

class Admin::ItemsController < ApplicationController

  def create
    Item.create(item_params)
    redirect_to '/items'
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to '/items'
  end

  def edit
    @item = Item.find(params[:id])
  end

  def index
    @items = Item.all
  end

  def new
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item)
    item.save

    redirect_to action: 'show', id: params[:id]
  end

  private

  def item_params
    params.permit(:name,
                  :description,
                  :unit_price,
                  :enabled,
                  :merchant_id)
  end
end