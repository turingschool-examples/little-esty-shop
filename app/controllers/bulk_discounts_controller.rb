class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end
  
  # def new
    
  # end
  
  # def create
    
  # end
  
  # def edit
    
  # end
  
  # def update
    
  # end
  
  # def destroy
    
  # end
  
# private
#   def _params
#     params.permit(:)
#   end
end