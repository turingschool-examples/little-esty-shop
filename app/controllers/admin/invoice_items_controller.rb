# app/controllers/invoice_item_controller.rb

class InvoiceItemsController < ApplicationController

  def create
    Invoice_item.create(invoice_item_params)
    redirect_to '/invoice_items'
  end

  def destroy
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.destroy
    redirect_to '/invoice_items'
  end

  def edit
    @invoice_item = InvoiceItem.find(params[:id])
  end

  def index
    @invoice_items = InvoiceItem.all
  end

  def new
  end

  def show
  @invoice_item = InvoiceItem.find(params[:id])
  end

  def update
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(invoice_item)
    invoice_item.save

    redirect_to action: 'show', id: params[:id]
  end

  private

  def invoice_item_params
    params.permit(:quantity,
                  :unit_price,
                  :unit_price,
                  :status,
                  :invoice_id,
                  :item_id)
  end
end