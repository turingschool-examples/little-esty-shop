class Merchant::DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_5_customers_array = @merchant.top_5_customers
    @customers = Customer.all
    @items = @merchant.items
    # @ready_to_ship_items = @items.joins(:invoice_items, :invoices).select('items.name, items.id, invoice_items.invoice_id, invoices.created_at').where('invoice_items.status = ?', 1).group('items.id, invoice_items.invoice_id, invoices.created_at')
    #                         .select('items.*, invoice_items.*')
    #                         .where('invoice_items.status = ? AND merchant_id = ?', 1, @merchant)
    # @invoice_to_ship = @ready_to_ship_items.pluck(:invoice_id) #.join()
    @ready_to_ship_items = @merchant.ready_to_ship
  end
end
