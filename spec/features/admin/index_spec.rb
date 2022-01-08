require 'rails_helper'

RSpec.describe 'Admin Dashboard Index' do
  describe 'view' do

    it 'I see a header indicating that I am on the admin dashboard' do
      visit "/admin"

      expect(page).to have_content("Welcome to the Admin Dashboard")
    end

    it ' I see a link to the admin merchants index' do
      visit "/admin"
      click_link "Merchants"
      expect(current_path).to eq('/admin/merchants')
    end

    it 'I see a link to the admin invoices index' do
      visit "/admin"
      click_link "Invoices"
      expect(current_path).to eq('/admin/invoices')
    end


    it 'I see a section for Incomplete Invoices with IDs of all invoices' do
      visit "/admin"

      expect(page).to have_content("Incomplete Invoices")
      within "#incompleteinvoices" do
        Invoice.incomplete_invoices.each do |invoice|
          expect(page).to have_content(invoice.id)
        end
        click_link("#{@invoice_4.id}")
      end

      expect(current_path).to eq(admin_invoice_path(@invoice_4.id))

    it 'shows top 5 customers' do
      visit admin_root_path

      expect(@customer_4.first_name).to appear_before(@customer_5.first_name)
      expect(@customer_5.first_name).to appear_before(@customer_6.first_name)
      expect(@customer_6.first_name).to appear_before(@customer_3.first_name)
      expect(@customer_3.first_name).to appear_before(@customer_2.first_name)
    end

    it 'shows the number of purchases for the top five customers' do
      visit admin_root_path

      within("#customer-#{@customer_4.id}") do
        expect(page).to have_content(@customer_4.first_name)
        expect(page).to have_content(@customer_4.last_name)
        expect(page).to have_content("4 Purchases")
      end
      expect(page).to_not have_content(@customer_1.last_name)
    end
  end
end
