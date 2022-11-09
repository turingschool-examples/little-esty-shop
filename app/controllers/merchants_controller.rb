class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    @favorite_customers = @merchant.top_5_customers
    @packaged_invoice_items = @merchant.items_ready_to_ship
  end

  def update 
    @merchant = Merchant.find(params[:id])
    enable_disable_toggle
  end

  def new
  end

  def create

  end

  def enable_disable_toggle
    if params[:button] == 'true'
      if @merchant.status == 'enabled'
        @merchant.update!(status: 'disabled')
      else
        @merchant.update!(status: 'enabled')
      end
      redirect_to "/admin/merchants"
    end
  end
end
