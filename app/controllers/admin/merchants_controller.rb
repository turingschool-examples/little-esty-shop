class Admin::MerchantsController < ApplicationController
  def index
   @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(merchant_params[:id])
  
    if merchant.update(name: merchant_params[:merchant][:merchant_name])
      redirect_to admin_merchant_path(merchant.id) 
      flash[:info] = "Your changes have been successfully updated"
    else
      redirect_to edit_admin_merchant_path(merchant.id)
      flash[:error] = "Error: Invalid form entry"
    end

    # 1] pry(#<Admin::MerchantsController>)> params
    # => <ActionController::Parameters {"utf8"=>"✓", "_method"=>"patch", "merchant"=>{"merchant_name"=>"Bob's Beauteez"}, "commit"=>"Save Changes", "controller"=>"admin/merchants", "action"=>"update", "id"=>"1286"} permitted: false>
    # [2] pry(#<Admin::MerchantsController>)> Merchant.find(params[:id])
    # => #<Merchant:0x00007f93926ef370 id: 1286, name: "Bob's Beauties", created_at: Sun, 26 Feb 2023 02:48:22 UTC +00:00, updated_at: Sun, 26 Feb 2023 02:48:22 UTC +00:00>
    # [3] pry(#<Admin::MerchantsController>)> Merchant.find(params[:id]).update(name: params[:merchant][:merchant_name])
    # => true
    # [4] pry(#<Admin::MerchantsController>)> Merchant.find(params[:id])
    # => #<Merchant:0x00007f9393bb52f0 id: 1286, name: "Bob's Beauteez", created_at: Sun, 26 Feb 2023 02:48:22 UTC +00:00, updated_at: Sun, 26 Feb 2023 02:51:02 UTC +00:00>
    # [5] pry(#<Admin::MerchantsController>)>
  end
  
  private
  
  def merchant_params
    params.permit(:id, merchant: :merchant_name)
    # x = params[:merchant].permit(:merchant_name)
  end
end