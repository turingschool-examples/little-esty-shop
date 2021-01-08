require 'rails_helper'

describe 'As an visitor' do
  describe 'When i visit the admin invoices index' do
    before :each do
      @merchant = create(:merchant)
      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant)
      @invoice_2 = create(:invoice, customer: @customer_1, merchant: @merchant)
      @invoice_3 = create(:invoice, customer: @customer_1, merchant: @merchant)
    end

    it 'I see the links to each invoice' do
      visit admin_invoices_path
      
      within("#invoices") do 
        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_2.id)
        expect(page).to have_content(@invoice_3.id)

        click_on @invoice_1.id
        expect(current_path).to eq(admin_invoice_path(@invoice_1))
      end
    end
  end
end