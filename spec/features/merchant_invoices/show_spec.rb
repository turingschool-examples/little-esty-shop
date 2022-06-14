require 'rails_helper'

RSpec.describe 'Merchant_Invoices Show Page', type: :feature do
  describe 'Merchant_Invoices User Story 2' do
    it "can display all information related to an invoice" do
      merchant = create(:merchant)
      customer1 = create(:customer, first_name: 'Luke', last_name: 'Skywalker')
      customer2 = create(:customer, first_name: 'Padme', last_name: 'Amidala')
      invoice = create(:invoice, customer: customer1)

      visit "/merchants/#{merchant.id}/invoices/#{invoice.id}"

      expect(page).to have_content("Invoice: #{invoice.id}")
      expect(page).to have_content("Status: #{invoice.status}")
      expect(page).to have_content("Created on: #{invoice.created_at.strftime("%A, %B %d, %Y")}")

      expect(page).to have_content("#{customer1.first_name} #{customer1.last_name}")
      expect(page).to_not have_content("#{customer2.first_name} #{customer2.last_name}")
    end
  end

  describe 'Merchant_Invoices User Story 3' do
    it 'can display items attributes that belongs to an invoice' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      customer1 = create(:customer, first_name: 'Luke', last_name: 'Skywalker')
      customer2 = create(:customer, first_name: 'Padme', last_name: 'Amidala')
      invoice1 = create(:invoice, customer: customer1)
      invoice2 = create(:invoice, customer: customer1)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant2)
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice2)

      visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"

      within '#itemtable' do
        expect(page).to have_content("Item Name")
        expect(page).to have_content("Quantity")
        expect(page).to have_content("Unit Price")
        expect(page).to have_content("Status")
        expect(page).to have_content(item1.name)
        expect(page).to_not have_content(item2.name)
        expect(page).to have_content(invoice_item1.quantity)
        expect(page).to have_content(invoice_item1.unit_price_converted)
        expect(page).to_not have_content(invoice_item2.unit_price_converted)
        expect(page).to have_content(invoice_item1.status)
      end
    end
  end

  describe "User Story 4 - Merchant Invoice Show Page: Total Revenue" do
    it "shows the total revenue of all items on the invoice" do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      customer1 = create(:customer, first_name: 'Luke', last_name: 'Skywalker')
      customer2 = create(:customer, first_name: 'Padme', last_name: 'Amidala')
      invoice1 = create(:invoice, customer: customer1)
      invoice2 = create(:invoice, customer: customer1)
      transaction1 = create(:transaction, invoice: invoice1, result: 0)
      transaction2 = create(:transaction, invoice: invoice1, result: 0)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant2)
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 12, unit_price: 100)
      invoice_item2 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 3, unit_price: 200)

      visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"

      expect(page).to have_content("Total Revenue: $1,800.00")
    end
  end

  describe "User Story 5 - Merchant Invoice Show Page: Update Item Status" do
    it "has a select field button for invoice item's status and has a button to update the status" do
      merchant1 = create(:merchant)
      customer1 = create(:customer, first_name: 'Luke', last_name: 'Skywalker')
      invoice1 = create(:invoice, customer: customer1)
      item1 = create(:item, merchant: merchant1)
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 12, unit_price: 100, status: 0)

      visit "/merchants/#{merchant1.id}/invoices/#{invoice1.id}"

      expect(invoice_item1.status).to eq("pending")

      within "#invoiceItem-#{invoice_item1.id}" do
        have_select :status,
        selected: "pending",
        options: ["pending", "packaged", "shipped"]

        select "packaged", from: :status
        click_button "Update Item Status"
      end

      expect(current_path).to eq("/merchants/#{merchant1.id}/invoices/#{invoice1.id}")
      invoice_item1.reload
      expect(invoice_item1.status).to eq("packaged")

      within "#invoiceItem-#{invoice_item1.id}" do
        have_select :status,
        selected: "packaged",
        options: ["pending", "packaged", "shipped"]
      end
    end
  end

  describe 'Merchant Invoice Show Page: Link to Applied Discounts' do
    it "can has links that go to bulk discount show page if applicable" do
      merchant1 = create(:merchant)
      customer1 = create(:customer, first_name: 'Luke', last_name: 'Skywalker')
      invoice1 = create(:invoice, customer: customer1)
      transaction1 = create(:transaction, invoice: invoice1, result: 0)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant1)
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 12, unit_price: 100)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice1, quantity: 5, unit_price: 200)
      bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 10, discount_percentage: 20)
      bulk_discount2 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 30)

      visit merchant_invoice_path(merchant1, invoice1)

      within "#invoiceItem-#{invoice_item1.id}" do
        expect(page).to have_link("Bulk Discount ID: #{bulk_discount1.id}")
        expect(page).to_not have_content("No Discount is Applied")
        click_link "Bulk Discount ID: #{bulk_discount1.id}"
      end

      expect(current_path).to eq merchant_bulk_discount_path(merchant1, bulk_discount1)

      visit merchant_invoice_path(merchant1, invoice1)

      within "#invoiceItem-#{invoice_item2.id}" do
        expect(page).to_not have_link("Bulk Discount ID: #{bulk_discount2.id}")
        expect(page).to_not have_link("Bulk Discount ID: #{bulk_discount1.id}")
        expect(page).to have_content("No Discount is Applied")
      end
    end
  end

  it "can display merchants discounted revenue" do
    merchant1 = create(:merchant)
    customer1 = create(:customer, first_name: 'Luke', last_name: 'Skywalker')
    invoice1 = create(:invoice, customer: customer1)
    transaction1 = create(:transaction, invoice: invoice1, result: 0)
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant1)
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 12, unit_price: 100)
    invoice_item2 = create(:invoice_item, item: item2, invoice: invoice1, quantity: 5, unit_price: 200)
    bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 10, discount_percentage: 20)
    bulk_discount2 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 30)

    visit merchant_invoice_path(merchant1, invoice1)

    within '#leftSide2' do
      expect(page).to have_content("Discounted Revenue: $1,960.00")
      expect(page).to have_content("Total Revenue: $2,200.00")
    end
  end
end
