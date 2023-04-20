require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page' do
  before :each do
    test_data
    visit admin_invoices_path
  end

  describe  'As an admin, when I visit the admin Invoices index' do
    it 'I see a list of all Invoice ids in the system.' do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_3.id)
      expect(page).to have_content(@invoice_4.id)
      expect(page).to have_content(@invoice_5.id)
      expect(page).to have_content(@invoice_6.id)
      expect(page).to have_content(@invoice_7.id)
      expect(page).to have_content(@invoice_8.id)
      expect(page).to have_content(@invoice_9.id)
      expect(page).to have_content(@invoice_10.id)
    end

    it 'each invoice id links to the admin invoice show page' do
      within "#invoice_#{@invoice_1.id}" do
        expect(current_path).to eq(admin_invoices_path)
        
        click_link("#{@invoice_1.id}")

        expect(current_path).to eq(admin_invoice_path(@invoice_1))
      end
      
      visit admin_invoices_path
      
      within "#invoice_#{@invoice_2.id}" do
        expect(current_path).to eq(admin_invoices_path)
       
        click_link("#{@invoice_2.id}")
        
        expect(current_path).to eq(admin_invoice_path(@invoice_2))
      end
    end
  end
end