class Merchants::InvoiceItemsController < ApplicationController
  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice_item = @merchant.invoice_items.find(params[:id])
    @invoice = @invoice_item.invoice
    # require 'pry'; binding.pry
    @invoice_item.update_attributes(status: params[:status])
    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end

  # From Adopt Don't Shop
  # def update
  #   application = Application.find(params[:id])
  #   unless params[:pet_adopt].nil?
  #     pet = Pet.find(params[:pet_adopt])
  #     pet_application = PetApplication.create!(application_id: application.id, pet_id: pet.id)
  #   end
  #   application.update_attributes(description: params[:description], status: 'Pending') unless params[:description].nil?
  #   redirect_to "/applications/#{application.id}"
  # end

  private

  def invoice_items_params
    params.require(:invoice_item)
    .permit(:quantity, :unit_price, :status, :item_id, :invoice_id)
  end
end