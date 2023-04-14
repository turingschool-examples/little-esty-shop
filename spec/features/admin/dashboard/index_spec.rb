require 'rails_helper'

RSpec.describe 'Admin Dashboard Index Page' do
  describe 'display' do
    before do
      visit admin_dashboard_path
    end

    it "Displays a header saying 'Admin Dashboard'" do

      expect(page).to have_content("Admin Dashboard")
    end

    it "Displays a link to the admin merchants index" do

      expect(page).to have_link("Merchants", href: admin_merchants_path)
    end

    it "Displays a link to the admin invoices index" do

      expect(page).to have_link("Invoices", href: admin_invoices_path)
    end
  end

  describe 'User Story 22' do 

    before (:each) do 
      test_data
    end

    it 'displays a section for "Incomplete Invoices"' do
      visit admin_dashboard_path

      expect(page).to have_content("Incomplete Invoices")
    end

    it 'displays a list of the ids of all invoices that have items that have not yet been shipped' do
      visit admin_dashboard_path

      expect(page).to have_content(@invoice_1.id)

      @invoice_item_1.update(status: 2)
      @invoice_item_21.update(status: 2)
      @invoice_item_41.update(status: 2)

      visit admin_dashboard_path

      expect(page).to_not have_content(@invoice_1.id)
    end

    it "each invoice id links to that invoice's admin show page" do
      visit admin_dashboard_path

      click_on "#{@invoice_1.id}"

      expect(current_path).to eq(admin_invoice_path(@invoice_1))
    end
  end
end
