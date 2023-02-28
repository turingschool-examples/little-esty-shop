require "rails_helper"

RSpec.describe "Admin Invoice Show Page" do
  describe "User Story 33" do 
    it 'When I visit an admin invoice show page, then I see information related to that invoice including: id, status, created at and customer name' do
      customer = create(:customer, first_name: "Adam", last_name: "Bailey")

      invoice = create(:invoice, customer: customer, status: 0, created_at: Date.new(2023,1,1))

      visit admin_invoice_path(invoice)

      expect(page).to have_content("Invoice ##{invoice.id}")
      expect(page).to have_content("Status: in progress")
      expect(page).to have_content("Created on: Sunday, January 1, 2023")
      expect(page).to have_content("Adam Bailey")
    end
  end
  context "Admin Invoice Item Information" do
    before(:each) do
      @merchant = create(:merchant, name: "Trader Bob's")
      
      @customer = create(:customer, first_name: "Adam", last_name: "Bailey")
  
      @item_1 = create(:item, name: "Jar", merchant: @merchant)
      @item_2 = create(:item, name: "La Croix", merchant: @merchant)
      @item_3 = create(:item, name: "Sunglasses", merchant: @merchant)
  
      @invoice = create(:invoice, customer: @customer, status: 0, created_at: Date.new(2023,1,1))
  
      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice, quantity: 2, unit_price: 299, status: "pending")
      @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice, quantity: 5, unit_price: 669, status: "packaged")
      @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice, quantity: 14, unit_price: 2420, status: "shipped")
  
      visit admin_invoice_path(@invoice)
    end

    describe "User Story 34" do
      it "When I visit an admin invoice show page, then I see all of the items on the invoice including: Item name, The quantity of the item ordered, The price the Item sold for
      The Invoice Item status" do

        within("#invoice_item-#{@invoice_item_1.id}") {
          expect(page).to have_content("Jar")
          expect(page).to have_content("2")
          expect(page).to have_content("$2.99")
          expect(page).to have_content("pending")
        }
        within("#invoice_item-#{@invoice_item_2.id}") {
          expect(page).to have_content("La Croix")
          expect(page).to have_content("5")
          expect(page).to have_content("$6.69")
          expect(page).to have_content("packaged")
        }
        within("#invoice_item-#{@invoice_item_3.id}") {
          expect(page).to have_content("Sunglasses")
          expect(page).to have_content("14")
          expect(page).to have_content("$24.20")
          expect(page).to have_content("shipped")
        }
      end
    end

    describe "User Story 35" do
      it "When I visit an admin invoice show page, I see the total revenue that will be generated from this invoice" do
        expect(page).to have_content("Total Revenue: $378.23")
      end
    end
  end
end