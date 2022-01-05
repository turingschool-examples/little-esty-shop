class MerchantsController < ApplicationController
  # def dashboard
  #   @merchant = Merchant.find(params[:merchant_id])
  #   # redirect_to "/merchants/#{@merchant.id}/dashboard"
  # end

  # def create
  #   @merchant = Merchant.new(merchant_params)

  #   respond_to do |format|
  #     if @merchant.save
  #       format.html { redirect_to @merchant, notice: "Merchant was successfully created." }
  #       format.json { render :show, status: :created, location: @merchant }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @merchant.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /merchants/1 or /merchants/1.json
  # def update
  #   respond_to do |format|
  #     if @merchant.update(merchant_params)
  #       format.html { redirect_to @merchant, notice: "Merchant was successfully updated." }
  #       format.json { render :show, status: :ok, location: @merchant }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @merchant.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /merchants/1 or /merchants/1.json
  # def destroy
  #   @merchant.destroy
  #   respond_to do |format|
  #     format.html { redirect_to merchants_url, notice: "Merchant was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_merchant
  #     @merchant = Merchant.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def merchant_params
  #     params.require(:merchant).permit(:name)
  #   end
end
