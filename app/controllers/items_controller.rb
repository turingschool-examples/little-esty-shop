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
    
    redirect_to edit_merchant_item_path(@merchant, @item)
  end
end
