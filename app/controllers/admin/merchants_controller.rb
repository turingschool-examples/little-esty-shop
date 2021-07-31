class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
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