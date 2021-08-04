class Merchant::MerchantsController < ApplicationController

  def index
    if params[:sort] == 'name'
      @merchants = Merchant.order_by_name(:name)
    elsif params[:sort] == 'date'
      @merchants = Merchant.order_by_date(:updated_at, :desc)
    else
      @merchants = Merchant.all
    end
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

end
