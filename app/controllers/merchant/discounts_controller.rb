class Merchant::DiscountsController < ApplicationController
  before_action :set_merchant, only: [ :index, :show, :new, :edit, :create, :update, :destroy ]
  before_action :set_discount, only: [ :show, :edit, :update, :destroy ]


  def index
    @next_three_holidays = API.next_three_holidays
    @discount1 = @merchant.discounts.find_by(name: "#{@next_three_holidays.keys.first}")
    @discount2 = @merchant.discounts.find_by(name: "#{@next_three_holidays.keys.second}")
    @discount3 = @merchant.discounts.find_by(name: "#{@next_three_holidays.keys.third}")
    
  end

  def show
  end

  def new
    @discount = Discount.new
  end

  def edit

  end

  def create
    @discount = @merchant.discounts.create(discount_params)
    if @discount.save
      redirect_to merchant_discounts_path(@merchant), flash: {notice: "Discount was successfully created." }
    else
      redirect_to new_merchant_discount_path(@merchant), flash: {notice: "Discount was not created." }
    end
  end


  def update
    if @discount.update(discount_params)
      redirect_to merchant_discount_path(@merchant, @discount), flash: {notice: "Successfully Updated Discount"}
    else
      redirect_to merchant_discount_path(@merchant, @discount), flash: {notice: "Discount not updated"}
    end
  end

  def destroy
    @discount.destroy
    redirect_to merchant_discounts_path(@merchant), flash: {notice: "Discount successfully destroyed"}
  end

  private
    def set_discount
      @discount = Discount.find(params[:id])
    end

    def set_merchant
      @merchant = Merchant.find(params[:merchant_id])
    end

    def discount_params
      params.require(:discount).permit(:name, :threshold, :percentage, :merchant_id)
    end
end
