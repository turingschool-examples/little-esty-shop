class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new({
      percentage: params[:percentage],
      quantity_threshold: params[:quantity_threshold],
      merchant_id: @merchant.id
    })
    if @bulk_discount.save
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
    else
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/new"
      flash[:notice] = "Please fill in valid information."
    end
  end
  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end
  def update
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.update(discount_params)
    if @bulk_discount.save
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_discount.id}"
    else
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_discount.id}/edit"
      flash[:notice] = "Please fill in valid information."
    end
  end
  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])

    @bulk_discount.destroy

    redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
  end

  private
  def discount_params
    params.permit(:percentage, :quantity_threshold)
  end
end
