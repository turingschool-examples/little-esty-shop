require 'rails_helper'

RSpec.describe "Admin Dashboard", type: :feature do
  let!(:customer) { create(:customer) }

  let!(:invoices) { create_list(:invoice, 4, customer: customer)}

  let!(:invoice_item1) { create(:invoice_item, invoice: invoices[1], status: 2) }
  let!(:invoice_item1) { create(:invoice_item, invoice: invoices[0], status: 2) }
  let!(:invoice_item2) { create(:invoice_item, invoice: invoices[2], status: 1) }
  let!(:invoice_item3) { create(:invoice_item, invoice: invoices[3], status: 0) }
  let!(:invoice_item4) { create(:invoice_item, invoice: invoices[1], status: 1) }
  let!(:invoice_item5) { create(:invoice_item, invoice: invoices[3], status: 0) }

  describe "Admin User Story 1 - Admin Dashboard" do
    it "can display a header" do
      visit '/admin'

      within '#leftSide' do
      expect(page).to have_content("Admin Dashboard")
      end
    end
  end
  describe "Admin User Story 2 - Admin Dashboard Links" do
    it "has a admin merchants index link and admin invoices index link" do
      visit '/admin'
      click_link 'Merchants'
      expect(current_path).to eq('/admin/merchants')

      visit '/admin'
      click_link 'Invoices'
      expect(current_path).to eq('/admin/invoices')
    end
  end

  describe 'incomplete invoices' do 
    it 'has a section where you can see the ids of all invoices not yet shipped' do 
      visit admin_index_path
      
      within "#leftSide2" do 
        expect(page).to have_content("Incomplete Invoices")
        expect(page).to have_content(invoices[2].id)
        expect(page).to have_content(invoices[1].id)
        expect(page).to have_content(invoices[3].id)
        expect(page).to_not have_content(invoices[0].id)
      end
    end

    it 'has each id as a link to a show page' do 
      visit admin_index_path

      within "#leftSide2" do 
        expect(page).to have_content("Incomplete Invoices")
        expect(page).to have_link("#{invoices[2].id}")
        expect(page).to have_link("#{invoices[1].id}")
        expect(page).to have_link("#{invoices[3].id}")
        expect(page).to_not have_link("#{invoices[0].id}")
        click_link "#{invoices[2].id}"
      end
      expect(current_path).to eq invoice_path(invoices[2].id)
    end
  end
end
