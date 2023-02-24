require 'rails_helper'

RSpec.describe "Dashboard", type: :feature do
  before(:each) do
    @merchant = create(:merchant, name: "Trader Bob's")

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_2.id)
    @invoice_3 = create(:invoice, customer_id: @customer_3.id)
    @invoice_4 = create(:invoice, customer_id: @customer_4.id)
    @invoice_5 = create(:invoice, customer_id: @customer_5.id)
    @invoice_6 = create(:invoice, customer_id: @customer_6.id)

    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    
    InvoiceItem.create(item: @item_1, invoice: @invoice_1)
    InvoiceItem.create(item: @item_1, invoice: @invoice_2)
    InvoiceItem.create(item: @item_1, invoice: @invoice_3)
    InvoiceItem.create(item: @item_1, invoice: @invoice_4)
    InvoiceItem.create(item: @item_1, invoice: @invoice_5)
    InvoiceItem.create(item: @item_2, invoice: @invoice_6)

    create(:transaction, invoice_id: @invoice_1.id, result: 0)
    2.times { create(:transaction, invoice_id: @invoice_2.id, result: 0) }
    3.times { create(:transaction, invoice_id: @invoice_3.id, result: 0) }
    4.times { create(:transaction, invoice_id: @invoice_4.id, result: 0) }
    5.times { create(:transaction, invoice_id: @invoice_5.id, result: 0) }
    
    visit "/merchants/#{@merchant.id}/dashboard"
  end

  describe "User story 1" do
    describe "When I visit my merchant dashboard" do
      it "As a merchant, when I visit my merchant dashboard 
        (/merchants/:merchant_id/dashboard) then I see the name of my merchant" do

        expect(page).to have_content("Trader Bob's")
      end
    end
  end

  describe "User story 2" do
    describe "When I visit my merchant dashboard" do
      it "shows a link to my merchant items index (/merchants/merchant_id/items)" do
        expect(page).to have_link("Items", href: "/merchants/#{@merchant.id}/items")
      end

      it "show a link to my merchant invoices index (/merchants/merchant_id/invoices)" do
        expect(page).to have_link("Invoices", href: "/merchants/#{@merchant.id}/invoices")
      end
    end
  end

  describe "User story 3" do
    describe "When I visit my merchant dashboard" do
      it "I see the names of the top 5 customers who have conducted the largest number of successful transactions with my merchant
        and next to each customer name I see the number of successful transactions they have conducted with my merchant" do  
        customer_5_full_name = "#{@customer_5.first_name} #{@customer_5.last_name}"
        customer_4_full_name = "#{@customer_4.first_name} #{@customer_4.last_name}"
        customer_3_full_name = "#{@customer_3.first_name} #{@customer_3.last_name}"
        customer_2_full_name = "#{@customer_2.first_name} #{@customer_2.last_name}"
        customer_1_full_name = "#{@customer_1.first_name} #{@customer_1.last_name}"
  
        expect("#{customer_5_full_name} - 5 purchases").to appear_before("#{customer_4_full_name} - 4 purchases")
        expect("#{customer_4_full_name} - 4 purchases").to appear_before("#{customer_3_full_name} - 3 purchases")
        expect("#{customer_3_full_name} - 3 purchases").to appear_before("#{customer_2_full_name} - 2 purchases")
        expect("#{customer_2_full_name} - 2 purchases").to appear_before("#{customer_1_full_name} - 1 purchases")
      end
    end
  end

  describe "User Story 4" do
    describe "Items Ready to Ship" do
      xit "shows a list of ordered items ready to ship" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
      end

      xit "shows the id of the invoice that ordered the item" do
        expect(page).to have_content("Invoice ##{@invoice_1.id}")
        expect(page).to have_content("Invoice ##{@invoice_2.id}")
      end

      xit "each invoice id is a link to my merchant's invoice show page" do
        expect(page).to have_link("Invoice ##{@invoice_1.id}",
        href: "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")
      end
    end
  end
end