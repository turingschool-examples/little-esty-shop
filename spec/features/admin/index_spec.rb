require 'rails_helper'

RSpec.describe 'Admin Index (Dashboard) Page', type: :feature do
  describe 'Admin Dashboard main page (User Story 19)' do
    it 'has a header' do
      visit admin_path

      expect(page).to have_content('Admin Dashboard')
      expect(page).to have_selector('h2')
    end
  end

  describe 'Admin Dashboard Links (User Story 20)' do
    it 'has links to the admin merchants index and admin invoices index' do
      visit admin_path

      expect(page).to have_link('Admin Merchants Index')
      expect(page).to have_link('Admin Invoices Index')

      click_link('Admin Merchants Index')
      expect(current_path).to eq(admin_merchants_path)

      visit admin_path
      click_link('Admin Invoices Index')
      expect(current_path).to eq(admin_invoices_path)
    end
  end

  describe 'Admin Dashboard Stats - Top Customers (User Story 21)' do
    before(:each) do
      @customer_1 = create(:customer) # 5 successful transactions
      @customer_2 = create(:customer) # 4 successful transactions
      @customer_3 = create(:customer) # 3 successful transactions
      @customer_4 = create(:customer) # 2 successful transactions
      @customer_5 = create(:customer) # 1 successful transaction

      5.times do
        invoice = create(:invoice, customer: @customer_1)
        create(:transaction, result: true, invoice: invoice)
      end

      4.times do
        invoice = create(:invoice, customer: @customer_2)
        create(:transaction, result: true, invoice: invoice)
      end

      3.times do
        invoice = create(:invoice, customer: @customer_3)
        create(:transaction, result: true, invoice: invoice)
      end

      2.times do
        invoice = create(:invoice, customer: @customer_4)
        create(:transaction, result: true, invoice: invoice)
      end

      invoice = create(:invoice, customer: @customer_5)
      create(:transaction, result: true, invoice: invoice)
      create(:transaction, result: false, invoice: invoice)

      @customer_6 = create(:customer, first_name: "Test", last_name: "Example") # no successful transactions
      2.times do
        invoice = create(:invoice, customer: @customer_6)
        create(:transaction, result: false, invoice: invoice)
      end
    end

    it 'displays the top 5 customers with their names and number of successful transactions' do
      visit admin_path

      expect(page).to have_content("Top Customers")

      within("#customer-#{@customer_1.id}") do
        expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
        expect(page).to have_content("5 purchases")
      end

      within("#customer-#{@customer_2.id}") do
        expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name}")
        expect(page).to have_content("4 purchases")
      end

      within("#customer-#{@customer_3.id}") do
        expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name}")
        expect(page).to have_content("3 purchases")
      end

      within("#customer-#{@customer_4.id}") do
        expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name}")
        expect(page).to have_content("2 purchases")
      end

      within("#customer-#{@customer_5.id}") do
        expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name}")
        expect(page).to have_content("1 purchases")
      end

      expect(@customer_1.first_name).to appear_before(@customer_2.first_name)
      expect(@customer_2.first_name).to appear_before(@customer_3.first_name)
      expect(@customer_3.first_name).to appear_before(@customer_4.first_name)
      expect(@customer_4.first_name).to appear_before(@customer_5.first_name)

      expect(page).to_not have_content(@customer_6.first_name)
      expect(page).to_not have_content(@customer_6.last_name)
    end
  end

  describe 'Admin Dashboard Incomplete Invoices (User Story 22)' do
    before(:each) do
      merchant = create(:merchant)
      customer = create(:customer)

      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      item_3 = create(:item, merchant: merchant)
      item_4 = create(:item, merchant: merchant)
      item_5 = create(:item, merchant: merchant)
      item_6 = create(:item, merchant: merchant)

      @invoice_1 = create(:invoice, customer: customer) # 2 items that have not shipped
      @invoice_2 = create(:invoice, customer: customer) # 1 item shipped, 1 not shipped
      @invoice_3 = create(:invoice, customer: customer) # 2 items that have shipped

      @invoice_item_1 = create(:invoice_item, status: "Pending", item: item_1, invoice: @invoice_1)
      @invoice_item_2 = create(:invoice_item, status: "Packaged", item: item_2, invoice: @invoice_1)
      @invoice_item_3 = create(:invoice_item, status: "Pending", item: item_3, invoice: @invoice_2)
      @invoice_item_4 = create(:invoice_item, status: "Shipped", item: item_4, invoice: @invoice_2)
      @invoice_item_5 = create(:invoice_item, status: "Shipped", item: item_5, invoice: @invoice_3)
      @invoice_item_6 = create(:invoice_item, status: "Shipped", item: item_6, invoice: @invoice_3)
    end

    it 'has a section for Incomplete Invoices that displays linked ids' do
      visit admin_path

      expect(page).to have_content("Incomplete Invoices")
      expect(page).to_not have_content("Invoice ##{@invoice_3.id}")

      within("#incomplete-invoices") do
        expect(page).to have_content("Invoice ##{@invoice_1.id}")
        click_link "Invoice ##{@invoice_1.id}"
        expect(current_path).to eq(admin_invoice_path(@invoice_1))
      end

      visit admin_path

      within("#incomplete-invoices") do
        expect(page).to have_content("Invoice ##{@invoice_2.id}")
        click_link "Invoice ##{@invoice_2.id}"
        expect(current_path).to eq(admin_invoice_path(@invoice_2))
      end
    end
  end

  describe 'Admin Dashboard Invoices Sorted by Least Recent (User Story 23)' do
    before(:each) do
      merchant = create(:merchant)
      customer = create(:customer)

      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      item_3 = create(:item, merchant: merchant)
      item_4 = create(:item, merchant: merchant)
      item_5 = create(:item, merchant: merchant)
      item_6 = create(:item, merchant: merchant)

      @invoice_1 = create(:invoice, created_at: '2023-03-26 09:54:09 UTC', customer: customer) #newest creation date
      @invoice_2 = create(:invoice, created_at: '2023-03-24 09:54:09 UTC', customer: customer) #oldest creation date
      @invoice_3 = create(:invoice, created_at: '2023-03-25 09:54:09 UTC', customer: customer) #middle creation date

      @invoice_item_1 = create(:invoice_item, status: "Pending", item: item_1, invoice: @invoice_1)
      @invoice_item_2 = create(:invoice_item, status: "Packaged", item: item_2, invoice: @invoice_1)
      @invoice_item_3 = create(:invoice_item, status: "Pending", item: item_3, invoice: @invoice_2)
      @invoice_item_4 = create(:invoice_item, status: "Shipped", item: item_4, invoice: @invoice_2)
      @invoice_item_5 = create(:invoice_item, status: "Packaged", item: item_5, invoice: @invoice_3)
      @invoice_item_6 = create(:invoice_item, status: "Shipped", item: item_6, invoice: @invoice_3)
    end

    it 'lists incomplete invoices with formatted creation dates in order from oldest to newest' do
      visit admin_path

      within("#incomplete-invoices") do
        expect("##{@invoice_2.id}").to appear_before("##{@invoice_3.id}")
        expect("##{@invoice_3.id}").to appear_before("##{@invoice_1.id}")

        expect(page).to have_content("Friday, March 24, 2023")
        expect(page).to have_content("Saturday, March 25, 2023")
        expect(page).to have_content("Sunday, March 26, 2023")
      end
    end
  end
end
