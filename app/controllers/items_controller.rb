class ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    if params[:status].present?
      item.update!(enabled: "disabled")
      redirect_to "/merchants/#{merchant.id}/items"
      flash[:success] = "Success: #{item.name} has been updated!"
    elsif
      item.update(item_params)
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
      flash[:success] = "Success: #{item.name} has been updated!"
    else
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}/edit"
      flash[:alert] = "Error: #{error_message(item.errors)}"
    end
  end

  def new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to "/merchants/#{params[:merchant_id]}/items/"
      flash[:success] = "Success: #{@item.name} has been created!"
    else
      redirect_to "/merchants/#{params[:merchant_id]}/items/new"
      flash[:alert] = "Error: #{error_message(item.errors)}"
    end
  end

  private
  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :enabled)
  end
end
