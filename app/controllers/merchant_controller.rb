class MerchantController < ApplicationController
  def index
    #render component: "HelloWorld", props: { greeting: "Hello from React-Rails." }
  end
  def dashboard
    @merchant = Merchant.find(params[:id])
  end
end
