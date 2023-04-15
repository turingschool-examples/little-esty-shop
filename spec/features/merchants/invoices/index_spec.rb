require 'rails_helper'

RSpec.describe 'merchant index page' do
  describe 'As a merchant, when I visit my merchants invoices index page' do
    before :each do
      test_data
      visit merchant_invoices_path(@merchant_2)
    end

    it 'I see all of the invoices that include 
      at least one of my merchants items' do
    
      within "#my_invoices" do
        expect(page).to have_content(@invoice_2.id)
        expect(page).to have_content(@invoice_10.id)
        expect(page).to have_content(@invoice_3.id)
        expect(page).to have_content(@invoice_1.id)
      end
    end

    it 'for each invoice I see its id and each id 
      links to the merchant invoice show page' do
      expect(page).to have_link("#{@invoice_2.id}")
      expect(page).to have_link("#{@invoice_10.id}")
      expect(page).to have_link("#{@invoice_3.id}")
      expect(page).to have_link("#{@invoice_1.id}")
    end
  end
end
