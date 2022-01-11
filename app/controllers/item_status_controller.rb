class ItemStatusController < ApplicationController
  before_action :do_merchant, only: [:update]
  before_action :do_item, only: [:update]

  def update
    @item.update(item_status_params)
    redirect_to merchant_items_path
  end

  private
    def item_status_params
      params.permit(:status)
    end
end
