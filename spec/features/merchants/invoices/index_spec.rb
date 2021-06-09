require 'rails_helper'

RSpec.describe Invoice, type: :feature do
  describe "Merchant Invoices" do
    before :each do
      @merchant_1 = Merchant.create!(name: "Regina's Ragin' Ragu")
      @merchant_2 = Merchant.create!(name: "Mark's Money Makin' Markers")
      @merchant_3 = Merchant.create!(name: "Caleb's California Catapults")
      @item_1 = @merchant_1.items.create!(name: "Zesty Zucchini", description: "Yummy", unit_price: 400)
      @item_2 = @merchant_1.items.create!(name: "Gnarly Garly", description: "Yum Yum Spicy", unit_price: 100)
      @customer_1 = Customer.create!(first_name: "Me", last_name: "Last Name")

      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 0)
      InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 400, status: "packaged")
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: 200, status: "shipped")
    end

    describe "should display all invoices that include one or more of my merchant's items" do
      it "and for each invoice I see an id, which links to the merchant's show page" do
      visit "/merchants/#{@merchant_1.id}/invoices"
      # expect(page).to have_content("#{@item_1.name}")
      # expect(page).to_not have_content("#{@item_2.name}")
      # expect(page).to have_link("#{@invoice_1.id}")
      # click_link("#{@invoice_2.id}")
      # expect(page).to have_current_path "/merchants/#{@merchant_1.id}/invoices/#{@invoice_2.id}"
      end
    end
  end
end
