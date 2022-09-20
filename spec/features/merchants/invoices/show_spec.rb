require 'rails_helper'

RSpec.describe 'Merchant Invoice Show' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bread Pitt")

    @customer_1 = Customer.create!(first_name: "Meat", last_name: "Loaf")
    @customer_2 = Customer.create!(first_name: "Shannon", last_name: "Dougherty")
    @customer_3 = Customer.create!(first_name: "Puff", last_name: "Daddy")

    @invoice_1 = Invoice.create!(status: 2, customer_id: @customer_1.id, created_at: Time.parse("Friday, September, 16, 2022"))
    @invoice_2 = Invoice.create!(status: 2, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status: 2, customer_id: @customer_3.id)

    @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_1.id)

    @invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 850, status: 0, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1300, status: 1, item_id: @item_2.id, invoice_id: @invoice_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 999, status: 2, item_id: @item_3.id, invoice_id: @invoice_3.id)
  end

    it 'shows information related to that invoice including id, status, and created_at' do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content("Invoice ID: #{@invoice_1.id}")
      expect(page).to have_content("completed")
      expect(page).to have_content("Invoice created at: Friday, September, 16, 2022")
      expect(page).to have_content("Meat Loaf")
    end

    it "shows all my items on the invoice including item name, quantity ordered, price item sold for, and invoice item status" do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
      expect(page).to have_content("Items on invoice:")
      expect(page).to have_content("Item name: ")
      expect(page).to have_content("Quantity: ")
      expect(page).to have_content("Sold at: ")
      expect(page).to have_content("Status: ")
    end
end
