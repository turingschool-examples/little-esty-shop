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
  end

  describe 'Then I see all of the customer information related to that invoice including:' do
    it 'displays customer first name and last name' do

      customer = create(:customer, first_name: "Minnie")

      invoice = create(:invoice, customer_id: customer.id)


      visit "/admin/invoices/#{invoice.id}"

      within (".customer") do
        expect(page).to have_content(customer.first_name)
        expect(page).to have_content(customer.last_name)
      end
    end
  end
end
