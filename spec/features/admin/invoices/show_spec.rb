require 'rails_helper'

describe 'As an visitor' do
  describe 'When i visit an admin invoice show apge' do
    before :each do
      @merchant = create(:merchant)

      @customer_1 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 0)
      
      @item = create(:item, merchant: @merchant)
      @item2 = create(:item, merchant: @merchant)
      
      @invoice_item = create(:invoice_item, item: @item, invoice: @invoice_1, status: 0)
      @invoice_item2 = create(:invoice_item, item: @item2, invoice: @invoice_1, status: 0)
    end

    it 'I see the invoices attributes' do
      visit admin_invoice_path(@invoice_1)
      
      within("#invoice-info") do 
        expect(page).to have_content("Invoice:")
        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_1.status)
        expect(page).to have_content(@invoice_1.date)
        expect(page).to have_content(@invoice_1.total_revenue)
      end
    end

    it 'I see the customer info pertaining to the invoice' do
      visit admin_invoice_path(@invoice_1)

      within("#customer-info") do 
        expect(page).to have_content("Customer: #{@invoice_1.customer_name}")
        expect(page).to have_content("Address: 123 Drury Ln")
        expect(page).to have_content("Nowhere, ID 10001")
      end
    end

    it 'I can update the invoices status' do
      visit admin_invoice_path(@invoice_1)

      within("#invoice-info") do
        expect(page).to have_content("STATUS: cancelled")
      end

      within("#update-status") do
        select("Completed", :from => "invoice[status]")
        click_button "Submit"
      end
      
      within("#invoice-info") do
        expect(page).to have_content("STATUS: completed")
      end
    end
  end
end