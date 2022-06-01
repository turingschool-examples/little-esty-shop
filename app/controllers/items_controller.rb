class ItemsController < ApplicationController
  before_action :find_merchant, only: [:index, :edit, :show, :update]
  before_action :find_item, only: [:edit, :show, :update]

  def index
    @items = @merchant.items
  end

  def show

  end

  def edit

  end

  def update
    if @item.update(item_params)
      flash[:message] = 'You have successfully updated this item!'
      redirect_to merchant_item_path(@merchant, @item)
    else
      flash[:message] = 'Please fill out all fields to update this item!'
      # render :new not sure why this doesn't work here
      redirect_to edit_merchant_item_path(@merchant, @item)
    end
  end


private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

end
