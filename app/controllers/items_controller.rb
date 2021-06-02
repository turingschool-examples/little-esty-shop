class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update]

  def index
    @items = Item.all
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
  end

  def edit
  end

  def update
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
