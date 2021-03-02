require 'rails_helper'

RSpec.describe 'Admin Invoices Show page' do
  describe 'When I visit the admin invoices (/admin/invoices)' do
      before (:each) do
        @invoice_1 = create(:invoice)
        @invoice_2 = create(:invoice)
        @invoice_3 = create(:invoice)
      end

    it 'When I click on the name of a invoice from the admin invoices index page' do
      visit "/admin/invoices"

      expect(page).to have_content("#{@invoice_1.id}")
      expect(page).to have_link("#{@invoice_1.id}")
      expect(page).to have_content("#{@invoice_2.id}")
      expect(page).to have_link("#{@invoice_2.id}")
      expect(page).to have_content("#{@invoice_3.id}")
      expect(page).to have_link("#{@invoice_3.id}")
    end

    it 'Then I am taken to that invoices admin show page (/admin/invoices/invoice_id)' do
      visit "/admin/invoices"

      expect(page).to have_link("#{@invoice_1.id}")
      click_link("#{@invoice_1.id}")
      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
      expect(page).to have_content("#{@invoice_1.id}")
    end

    it 'displays customer first name and last name for that invoice' do

      customer = create(:customer, first_name: "Minnie")
      invoice = create(:invoice, customer_id: customer.id)

      visit "/admin/invoices/#{invoice.id}"

      within (".customer") do
        expect(page).to have_content(customer.first_name)
        expect(page).to have_content(customer.last_name)
      end
    end

    it 'I see all of the items on the invoice with their: name, quantity, price sold, invoice item status' do
      customer = create(:customer, first_name: "Minnie")
      invoice = create(:invoice, customer: customer)
      item_1 = create(:item, name: "Fancy Chair")
      item_2 = create(:item, name: "Mineral Water")
      invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 7, unit_price: 5)
      invoice_item_2 = create(:invoice_item, invoice_id: invoice.id, item_id: item_2.id, quantity: 9, unit_price: 5.49)

      visit "/admin/invoices/#{invoice.id}"

      expect(page).to have_content("Items on this Invoice:")
      within ("#item-#{item_1.id}") do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(invoice.find_invoice_item(item_1.id).quantity)
        expect(page).to have_content(invoice.find_invoice_item(item_1.id).unit_price)
        expect(page).to have_content(invoice.find_invoice_item(item_1.id).status)
      end
      within ("#item-#{item_2.id}") do
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(invoice.find_invoice_item(item_2.id).quantity)
        expect(page).to have_content(invoice.find_invoice_item(item_2.id).unit_price)
        expect(page).to have_content(invoice.find_invoice_item(item_2.id).status)
      end
    end
  end
end
