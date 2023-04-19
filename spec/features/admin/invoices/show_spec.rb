require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page', type: :feature do
  before (:each) do
    @merchant_1 = create(:merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id,status: 'In Progress')
    @invoice_2 = create(:invoice, customer_id: @customer_2.id,status: 'Cancelled')
    @invoice_3 = create(:invoice, customer_id: @customer_2.id, status: 'Completed')
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)
    @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 50, unit_price: 50)
    @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 100, unit_price: 100)
    @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 150, unit_price: 150)
    @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 200, unit_price: 200)
  end

  describe "Admin Invoice Show Page (User Story 33)" do
    it "displays all information related to that invoice" do
      visit admin_invoice_path(@invoice_1)
      within("##{@invoice_1.id}_id") do
        expect(page).to have_content("Invoice ID: #{@invoice_1.id}")
        expect(page).to have_content("Invoice Status:")
        expect(page).to have_field('invoice_status', with: "#{@invoice_1.status}")
        expect(page).to have_content("Invoice Created At: #{format_date(@invoice_1.created_at)}")
        expect(page).to have_content("Customer Name: #{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")

        expect(page).to_not have_content("Invoice ID: #{@invoice_2.id}")
        expect(page).to_not have_content("Customer Name: #{@invoice_2.customer.first_name} #{@invoice_2.customer.last_name}")
      end

      visit admin_invoice_path(@invoice_2)
      within("##{@invoice_2.id}_id") do
        expect(page).to have_content("Invoice ID: #{@invoice_2.id}")
        expect(page).to have_content("Invoice Status:")
        expect(page).to have_content("Invoice Created At: #{format_date(@invoice_2.created_at)}")
        expect(page).to have_content("Customer Name: #{@invoice_2.customer.first_name} #{@invoice_2.customer.last_name}")

        expect(page).to_not have_content("Invoice ID: #{@invoice_1.id}")
        expect(page).to_not have_content("Customer Name: #{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")
      end
    end
  end

  describe "Admin Invoice Show Page: Invoice Item Information (User Story 34)" do
    it "displays all items on the invoice" do
      visit admin_invoice_path(@invoice_1)
      within ("##{@invoice_1.id}_id") do
        expect(page).to have_content("Item name: #{@item_1.name}")
        expect(page).to have_content("Item name: #{@item_2.name}")

        expect(page).to_not have_content(@item_3.name)
      end

      visit admin_invoice_path(@invoice_2)
      within ("##{@invoice_2.id}_id") do
        expect(page).to have_content("Item name: #{@item_1.name}")
        expect(page).to have_content("Item name: #{@item_3.name}")

        expect(page).to_not have_content(@item_2.name)
      end
    end

    it "displays item name, quantity ordered, price sold, and Invoice Item status" do
      visit admin_invoice_path(@invoice_1)

      within("#item_#{@item_1.id}") do
        expect(page).to have_content("Quantity Ordered: #{@invoice_item_1.quantity}")
        expect(page).to have_content("Item sold price: #{format_currency(@invoice_item_1.unit_price)}")
        expect(page).to have_content("Invoice Item status: #{@invoice_item_1.status}")

        expect(page).to_not have_content("Item name: #{@item_2.name}")
        expect(page).to_not have_content("Item sold price: #{format_currency(@invoice_item_2.unit_price)}")
      end

      within("#item_#{@item_2.id}") do
        expect(page).to have_content("Quantity Ordered: #{@invoice_item_2.quantity}")
        expect(page).to have_content("Item sold price: #{format_currency(@invoice_item_2.unit_price)}")
        expect(page).to have_content("Invoice Item status: #{@invoice_item_2.status}")

        expect(page).to_not have_content("Item name: #{@item_1.name}")
        expect(page).to_not have_content("Item sold price: #{format_currency(@invoice_item_1.unit_price)}")
      end

      visit admin_invoice_path(@invoice_2)
      within("#item_#{@item_1.id}") do
        expect(page).to have_content("Quantity Ordered: #{@invoice_item_3.quantity}")
        expect(page).to have_content("Item sold price: #{format_currency(@invoice_item_3.unit_price)}")
        expect(page).to have_content("Invoice Item status: #{@invoice_item_3.status}")

        expect(page).to_not have_content("Item name: #{@item_3.name}")
        expect(page).to_not have_content("Quantity Ordered: #{@invoice_item_4.quantity}")
        expect(page).to_not have_content("Item sold price: #{format_currency(@invoice_item_4.unit_price)}")
      end

      within("#item_#{@item_3.id}") do
        expect(page).to have_content("Quantity Ordered: #{@invoice_item_4.quantity}")
        expect(page).to have_content("Item sold price: #{format_currency(@invoice_item_4.unit_price)}")
        expect(page).to have_content("Invoice Item status: #{@invoice_item_4.status}")

        expect(page).to_not have_content("Item name: #{@item_1.name}")
        expect(page).to_not have_content("Quantity Ordered: #{@invoice_item_3.quantity}")
        expect(page).to_not have_content("Item sold price: #{format_currency(@invoice_item_3.unit_price)}")
      end
    end
  end

  describe "Admin Invoice Show Page: Total Revenue (User Story 35)" do
    it "displays the total revenue that will be generated from this invoice"do
      visit admin_invoice_path(@invoice_1)
      within("##{@invoice_1.id}_id") do
        expect(page).to have_content("Total Revenue: $125.00")

        expect(page).to_not have_content("Total Revenue: $625.00")
      end

      visit admin_invoice_path(@invoice_2)
      within("##{@invoice_2.id}_id") do
        expect(page).to have_content("Total Revenue: $625.00")

        expect(page).to_not have_content("Total Revenue: $125.00")
      end
    end
  end

  describe "Admin Invoice Show Page: Update Invoice Status (User Story 36)" do
    it "displays invoice status as a select field with current status selected" do
      visit admin_invoice_path(@invoice_1)
      within ("##{@invoice_1.id}_id") do
        expect(page).to have_content("Invoice Status:")
        expect(page).to have_field('invoice_status', with: "#{@invoice_1.status}")
      end
      visit admin_invoice_path(@invoice_2)
      within ("##{@invoice_2.id}_id") do
        expect(page).to have_content("Invoice Status:")
        expect(page).to have_field('invoice_status', with: "#{@invoice_2.status}")
      end
    end

    it "changing field and clicking 'Update Invoice Status' updates invoice status and redirects to /admin/invoices/:id" do
      visit admin_invoice_path(@invoice_1)
      within ("##{@invoice_1.id}_id") do
        expect(@invoice_1.status).to eq("In Progress")
        select "Completed", from: 'invoice_status'
        click_button "Update Invoice Status"
        expect(@invoice_1.reload.status).to eq("Completed")
        expect(current_path).to eq(admin_invoice_path(@invoice_1))
      end
      visit admin_invoice_path(@invoice_2)
      within ("##{@invoice_2.id}_id") do
        expect(@invoice_2.status).to eq("Cancelled")
        select "In Progress", from: 'invoice_status'
        click_button "Update Invoice Status"
        expect(@invoice_2.reload.status).to eq("In Progress")
        expect(current_path).to eq(admin_invoice_path(@invoice_2))
      end
    end
  end
end
