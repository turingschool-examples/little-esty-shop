require 'rails_helper'

RSpec.describe 'merchant invoice show' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
    @item_5 = create(:item, merchant: @merchant_2)
    @item_6 = create(:item, merchant: @merchant_2)
    @item_7 = create(:item, merchant: @merchant_3)
    @item_8 = create(:item, merchant: @merchant_3)
    @item_9 = create(:item, merchant: @merchant_3)
    @item_10 = create(:item, merchant: @merchant_3)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)

    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_1)
    @invoice_3 = create(:invoice, customer: @customer_1)
    @invoice_4 = create(:invoice, customer: @customer_2)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1)
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2)
    @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_3, status: 0)
    @invoice_item_4 = create(:invoice_item, item: @item_4, invoice: @invoice_3, status: 1) 
    @invoice_item_5 = create(:invoice_item, item: @item_5, invoice: @invoice_4)
    @invoice_item_6 = create(:invoice_item, item: @item_7, invoice: @invoice_4)
  end

  describe '/merchants/merchant_id/invoices/invoice_id' do
    it 'shows all information related to that invoice including invoice id, invoice status, invoice creation date, customer name' do
      visit merchant_invoice_path(@merchant_2, @invoice_2)

      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_2.status)
      expect(page).to have_content(@invoice_2.created_at.to_formatted_s(:admin_invoice_date))
      expect(page).to have_content(@invoice_2.customer.first_name)
      expect(page).to have_content(@invoice_2.customer.last_name)
      expect(page).to_not have_content(@invoice_1.id)
    end

    it 'shows all items on an invoice and their attributes including item name, quantity, sale price, invoice item status' do
      visit merchant_invoice_path(@merchant_2, @invoice_3)
    
      expect(page).to have_content(@invoice_3.id)
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content((@invoice_item_3.unit_price / 100.00))
      expect(page).to have_content(@invoice_item_3.quantity)
      expect(page).to_not have_content(@item_1.name)
    end

    it 'shows total revenue for all items on invoice' do
      visit merchant_invoice_path(@merchant_2, @invoice_3)

      expect(page).to have_content("Invoice Total: $#{@invoice_3.total_revenue}")

      visit merchant_invoice_path(@merchant_1, @invoice_1)

      expect(page).to have_content("Invoice Total: $#{@invoice_1.total_revenue}")
      expect(page).to_not have_content("Invoice Total: $#{@invoice_3.total_revenue}")
    end

    it 'shows each invoice items status is a select field and item current status is selected' do
 
      visit merchant_invoice_path(@merchant_2, @invoice_3)
      within "#item-#{@item_3.id}" do
        expect(page).to have_select("status", selected: "packaged")
        expect(page).to_not have_select("status", selected: "pending")
        
        select("shipped", from: "status")
        click_on "Update Item Status"
      end

      expect(current_path).to eq("/merchants/#{@merchant_2.id}/invoices/#{@invoice_3.id}")
      expect(page).to have_select("status", selected: "shipped")
    end
  end
end