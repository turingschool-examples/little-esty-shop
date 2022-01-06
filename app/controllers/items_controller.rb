class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  # GET /items/1 or /items/1.json
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  # GET /items/new
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  # POST /items or /items.json
  def create
    merchant = Merchant.find(params[:merchant_id])
    item = Item.new(item_params)
    item.save
    redirect_to "/merchants/#{merchant.id}/items/"
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    item.update(item_params)
    item.save
    redirect_to "/merchants/#{merchant.id}/items/#{item.id}"
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id,)
  end
end
