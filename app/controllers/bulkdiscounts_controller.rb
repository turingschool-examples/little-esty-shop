class BulkdiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulkdiscounts = @merchant.bulkdiscounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulkdiscount = Bulkdiscount.find(params[:bulkdiscount_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    bulkdiscount = merchant.bulkdiscounts.new(name: params[:name], percentage: params[:percentage], threshold: params[:threshold])

    if bulkdiscount.save
      redirect_to "/merchants/#{merchant.id}/bulkdiscounts"
    else
      redirect_to "/merchants/#{merchant.id}/bulkdiscounts/new"
      flash[:alert] = "Error: #{error_message(item.errors)}"
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @bulkdiscount = Bulkdiscount.find(params[:bulkdiscount_id]).destroy
    redirect_to "/merchants/#{@merchant.id}/bulkdiscounts"
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulkdiscount = Bulkdiscount.find(params[:bulkdiscount_id])
  end


end
