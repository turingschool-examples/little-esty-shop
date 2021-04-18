class MerchantsController < ApplicationController

  def welcome
  end

  def show
    @merchant = Merchant.find(params[:id])

  #  @top_five = Merchant.joins(items: :invoice_items).joins(:invoices)#.joins(:customers).joins(:transaction)
  #  @top_five_1 = Merchant.joins(:items).joins(:invoice_items).joins(:invoices).joins(:customers).joins(:transaction).where("id = ?", @merchant)
  #  @top_five_1 = Merchant.joins(:items).joins(:invoice_items)
    @top_five = @merchant.top_five_customers

#    @ship_ready = Merchant.joins(items: {invoice_items: :invoice}).where("merchants.id = ?", @merchant.id).where("invoice.status != ?", "cancelled").where("invoice_item.status != ?", "shiped").select(:name)

    # @customers = Customer.joins(invoices: {invoice_item: {item: :merchant}})
    #   .where("merchants.id = ?", @merchant.id).limit(5)
    #   .group(:customer_id).count

  end

  def index
    @merchants = Merchant.all
  end

  def item_index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items.all
  end

  def item_show
  end

  def invoice_index
  end

  def invoice_show
  end

end
