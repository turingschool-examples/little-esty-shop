class Merchant::ItemsController < ApplicationController
  def index
    @merchant_items = Item.all    #helper method for item specific to merchant
  end

  def show
    #merchant specific item
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end
end
