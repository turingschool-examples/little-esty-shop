class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def update
        item = Item.find(params[:id])
        if item.update(item_params)

          if params[:status].present?
            redirect_to merchant_items_path(item.merchant)
            flash[:success] = "Item successfully updated!"
          else
            redirect_to merchant_item_path(item.merchant, item)
            flash[:success] = "Item successfully updated!"
          end

        else
            redirect_to edit_merchant_item_path(item.merchant, item)
            flash[:alert] = "Error: #{error_message(item.errors)}"
        end
    end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :status,)
  end
end

