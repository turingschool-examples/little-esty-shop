class Merchant::DiscountsController < ApplicationController
  before_action :set_merchant, only: [ :index, :show, :edit, :update ]
  before_action :set_discount, only: [ :show, :edit, :update, :destroy ]


  def index
    # @merchant = Merchant.find(params[:merchant_id])
    # @discounts = @merchant.discounts.all
  end

  def show
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.new
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.create(discount_params)
    if @discount.save
      redirect_to merchant_discounts_path(@merchant), flash: {notice: "Discount was successfully created." }
    else
      redirect_to new_merchant_discount_path(@merchant), flash: {notice: "Discount was not created." }
    end
  end

  # PATCH/PUT /discounts/1 or /discounts/1.json
  def update
    if @discount.update(discount_params)
      redirect_to merchant_discount_path(@merchant, @discount), flash: {notice: "Successfully Updated Discount"}
    #   # format.json { render :show, status: :ok, location: @discount }
    else
      redirect_to merchant_discount_path(@merchant, @discount), flash: {notice: "Discount not updated"}
      # format.html { render :edit, status: :unprocessable_entity }
      # format.json { render json: @discount.errors, status: :unprocessable_entity }
    end
  end
  #
  # DELETE /discounts/1 or /discounts/1.json
  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    # @merchant = Merchant.find(params[:])
    @discount = Discount.find(params[:id]).destroy
    redirect_to merchant_discounts_path(@merchant), flash: {notice: "Discount successfully destroyed"}
    # end
  end
  #
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discount
      @discount = Discount.find(params[:id])
    end

    def set_merchant
      @merchant = Merchant.find(params[:merchant_id])
    end
  #
  #   # Only allow a list of trusted parameters through.
    def discount_params
      params.require(:discount).permit(:name, :threshold, :percentage, :merchant_id)
    end
end
