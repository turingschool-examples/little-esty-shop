require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page' do
  before(:each) do
    test_data
  end

  describe 'User Story 15' do 
    it 'I see information related to that invoice(Invoice ID, Status, Created Date, Customer Name)' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      within '#invoice_info' do
        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_1.status)
        expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
        expect(page).to have_content(@customer_1.first_name)
        expect(page).to have_content(@customer_1.last_name)
      end

      visit merchant_invoice_path(@merchant_2, @invoice_7)

      within'#invoice_info' do
        expect(page).to have_content(@invoice_7.id)
        expect(page).to have_content(@invoice_7.status)
        expect(page).to have_content(@invoice_7.created_at.strftime("%A, %B %d, %Y"))
        expect(page).to have_content(@customer_3.first_name)
        expect(page).to have_content(@customer_3.last_name)
      end
    end
  end

  describe 'User Story 17' do
    it 'I see the total revenue that will be generated from this invoice' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)
      within "#invoice_revenue" do
        expect(page).to have_content(@invoice_1.total_revenue)
      end

      visit merchant_invoice_path(@merchant_2, @invoice_7)
      within "#invoice_revenue" do
        expect(page).to have_content(@invoice_7.total_revenue)
      end
    end
  end
end
