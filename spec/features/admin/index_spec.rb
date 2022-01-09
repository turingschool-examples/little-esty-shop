require 'rails_helper'

RSpec.describe 'Admin Dashboard Index' do
  describe 'view' do

    it 'I see a header indicating that I am on the admin dashboard' do
      visit "/admin"

      expect(page).to have_content("Welcome to the admin dashboard")
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
    end

    it 'next to each invoice id I see the date that the invoice was created' do
      visit "/admin"

      within("#invoice-#{@invoice_4.id}") do
        expect(page).to have_content("#{@invoice_4.created_at.strftime("%A, %B %d, %Y")}")
      end
    end

    it 'orders the list of inclomplete invoices from oldest to newest' do
      visit "/admin"

      within "#incompleteinvoices" do
        Invoice.incomplete_invoices.each do |invoice|
          expect("#{@invoice_4.id}").to appear_before("#{@invoice_3.id}")
          expect("#{@invoice_3.id}").to appear_before("#{@invoice_2.id}")
          expect("#{@invoice_2.id}").to appear_before("#{@invoice_1.id}")
        end
      end
    end
  end
end
