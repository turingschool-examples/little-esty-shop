class MerchantController < ApplicationController
  def index
    #render component: "HelloWorld", props: { greeting: "Hello from React-Rails." }
  end
  def dashboard
    @merchant = Merchant.find(params[:id])
  end
  def items
    
  end
  def invoices
    
  end
end
