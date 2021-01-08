require 'rails_helper'

describe 'As an visitor' do
  describe 'When i visit an admin invoice show apge' do
    before :each do
      @merchant = create(:merchant)
      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant)
      @invoice_2 = create(:invoice, customer: @customer_1, merchant: @merchant)
      @invoice_3 = create(:invoice, customer: @customer_1, merchant: @merchant)
    end

    it 'I see the invoices attributes' do
      visit admin_invoice_path(@invoice_1)
      
      expect(page).to have_content("Invoice:")
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.date)
    end

    it 'I see the customer info pertaining to the invoice' do
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_content("Customer: #{@invoice_1.customer_name}")
      expect(page).to have_content("Address: 123 Drury Ln")
      expect(page).to have_content("Nowhere, ID 10001")
    end
  end
end