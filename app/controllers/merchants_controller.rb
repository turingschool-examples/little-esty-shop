class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
  end

  def admin_index
    @merchants = Merchant.all
  end

  def admin_show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
       if params[:status]
         redirect_to "/admin/merchants"
      elsif @merchant.update(merchant_params)
        redirect_to "/admin/merchants/#{@merchant.id}"
          flash[:alert] = "Sucessfully Updated"
      end
    end
  #   @merchant = Merchant.find(params[:id])
  #   @merchant.update(merchant_params)
  #   redirect_to "/admin/merchants/#{@merchant.id}"
  #   flash[:alert] = "Sucessfully Updated"
  # end
  #
  # def update
  #   @merchant = Merchant.find(params[:id])
  #   @merchant.update(merchant_params)
  #   redirect_to "/admin/merchants"
  # end

  private
  def merchant_params
    params.permit(:id, :name, :status)
  end
end
