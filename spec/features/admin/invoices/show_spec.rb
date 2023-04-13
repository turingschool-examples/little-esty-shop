require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page', type: :feature do
  before (:each) do
    @merchant_1 = create(:merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_2.id)
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)
    @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 5, unit_price: 5)
    @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 10, unit_price: 10)
    @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 15, unit_price: 15)
    @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 20, unit_price: 20)
  end

  describe "Admin Invoice Show Page (User Story 33)" do
    it "displays all information related to that invoice" do
      visit admin_invoice_path(@invoice_1)
      within("##{@invoice_1.id}_id") do
        expect(page).to have_content("Invoice ID: #{@invoice_1.id}")
        expect(page).to have_content("Invoice Status: #{@invoice_1.status}")
        expect(page).to have_content("Invoice Created At: #{@invoice_1.convert_created_at}")
        expect(page).to have_content("Customer Name: #{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")

        expect(page).to_not have_content("#{@invoice_2.id}")
        expect(page).to_not have_content("#{@invoice_2.customer.first_name} #{@invoice_2.customer.last_name}")
      end

      visit admin_invoice_path(@invoice_2)
      within("##{@invoice_2.id}_id") do
        expect(page).to have_content("Invoice ID: #{@invoice_2.id}")
        expect(page).to have_content("Invoice Status: #{@invoice_2.status}")
        expect(page).to have_content("Invoice Created At: #{@invoice_2.convert_created_at}")
        expect(page).to have_content("Customer Name: #{@invoice_2.customer.first_name} #{@invoice_2.customer.last_name}")

        expect(page).to_not have_content("#{@invoice_1.id}")
        expect(page).to_not have_content("#{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")
      end
    end
  end

  describe "Admin Invoice Show Page: Invoice Item Information (User Story 34)" do
    it "displays all items on the invoice" do
      visit admin_invoice_path(@invoice_1)
      within ("##{@invoice_1.id}_id") do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)

        expect(page).to_not have_content(@item_3.name)
      end

      visit admin_invoice_path(@invoice_2)
      within ("##{@invoice_2.id}_id") do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_3.name)

        expect(page).to_not have_content(@item_2.name)
      end
    end

    it "displays item name, quantity ordered, price sold, and Invoice Item status" do
      visit admin_invoice_path(@invoice_1)
      within("#item_#{@item_1.id}") do
        expect(page).to have_content(@invoice_item_1.quantity)
        expect(page).to have_content(@invoice_item_1.unit_price)
        expect(page).to have_content(@invoice_item_1.status)
  
        expect(page).to_not have_content(@item_2.name)
        expect(page).to_not have_content(@invoice_item_2.quantity)
        expect(page).to_not have_content(@invoice_item_2.unit_price)
      end
  
      within("#item_#{@item_2.id}") do
        expect(page).to have_content(@invoice_item_2.quantity)
        expect(page).to have_content(@invoice_item_2.unit_price)
        expect(page).to have_content(@invoice_item_2.status)
  
        expect(page).to_not have_content(@item_1.name)
        expect(page).to_not have_content(@invoice_item_1.quantity)
        expect(page).to_not have_content(@invoice_item_1.unit_price)
      end

      visit admin_invoice_path(@invoice_2)
      within("#item_#{@item_1.id}") do
        expect(page).to have_content(@invoice_item_3.quantity)
        expect(page).to have_content(@invoice_item_3.unit_price)
        expect(page).to have_content(@invoice_item_3.status)
  
        expect(page).to_not have_content(@item_3.name)
        expect(page).to_not have_content(@invoice_item_4.quantity)
        expect(page).to_not have_content(@invoice_item_4.unit_price)
      end

      within("#item_#{@item_3.id}") do
        expect(page).to have_content(@invoice_item_4.quantity)
        expect(page).to have_content(@invoice_item_4.unit_price)
        expect(page).to have_content(@invoice_item_4.status)

        expect(page).to_not have_content(@item_1.name)
        expect(page).to_not have_content(@invoice_item_3.quantity)
        expect(page).to_not have_content(@invoice_item_3.unit_price)
      end
    end
  end

  describe "Admin Invoice Show Page: Total Revenue (User Story 35)" do
    it "displays the total revenue that will be generated from this invoice"do
      visit admin_invoice_path(@invoice_1)
      within("##{@invoice_1.id}_id") do
        expect(page).to have_content("Total Revenue: 125")

        expect(page).to_not have_content("Total Revenue: 625")
      end

      visit admin_invoice_path(@invoice_2)
      within("##{@invoice_2.id}_id") do
        expect(page).to have_content("Total Revenue: 625")

        expect(page).to_not have_content("Total Revenue: 125")
      end
    end
  end


end