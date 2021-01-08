require 'rails_helper'

describe 'As an visitor' do
  describe 'When i visit an admin invoice show apge' do
    before :each do
      @merchant = create(:merchant)

      @customer_1 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant)
      @invoice_2 = create(:invoice, customer: @customer_1, merchant: @merchant)
      @invoice_3 = create(:invoice, customer: @customer_1, merchant: @merchant)
      
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

    it 'I can update the invoice & see its information' do
      visit admin_invoice_path(@invoice_1)

      expect(@invoice_item.status).to eq("pending")

      within("#item-info") do
        within("#form-#{@invoice_item.id}") do 
          select("Shipped", :from => "invoice_item[status]")
          click_button "Submit"
        end
      end

      expect(@invoice_item.reload.status).to eq("shipped")
      expect(@invoice_item2.reload.status).to eq("pending")

      within("#item-info") do   
        within("#form-#{@invoice_item2.id}") do 
          select("Packaged", :from => "invoice_item[status]")
          click_button "Submit"
        end
      end

      expect(@invoice_item.reload.status).to eq("shipped")
      expect(@invoice_item2.reload.status).to eq("packaged")
    end
  end
end