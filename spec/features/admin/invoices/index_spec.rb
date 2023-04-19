require 'rails_helper'

RSpec.describe 'Admin Invoice Index Page' do
  before(:each) do
    test_data
    stub_request(:get, "https://api.unsplash.com/photos/random?client_id=FlgsxiCZm-o34965PDOwh6xVsDINZFbzSwcz0__LKZQ&query=merchant")
      .to_return(status: 200, body: File.read('./spec/fixtures/merchant.json'))
    stub_request(:get, "https://api.unsplash.com/photos/5Fxuo7x-eyg?client_id=aOXB56mTdUD88zHCvISJODxwbTPyRRsOk0rA8Ha-cbc")
      .to_return(status: 200, body: File.read('./spec/fixtures/app_logo.json'))
  end

  describe 'User Story 32' do
    it 'displays all invoice ids' do
      visit '/admin/invoices'
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_3.id)
    end

    it 'links to the admin invoice show page' do
      visit '/admin/invoices'
      within "#invoice-#{@invoice_1.id}" do
        click_link "#{@invoice_1.id}"
      end
      expect(current_path).to eq(admin_invoice_path(@invoice_1))

      visit '/admin/invoices'
      
      within "#invoice-#{@invoice_2.id}" do
        click_link "#{@invoice_2.id}"
      end
      expect(current_path).to eq(admin_invoice_path(@invoice_2))
    end
  end
end