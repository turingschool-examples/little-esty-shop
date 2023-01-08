require 'rails_helper'

RSpec.describe 'merchant invoice index' do
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
    @invoice_1.items << @item_1
    @invoice_2 = create(:invoice, customer: @customer_1)
    @invoice_3 = create(:invoice, customer: @customer_1)
    @invoice_3.items << @item_3
    @invoice_3.items << @item_4
    @invoice_4 = create(:invoice, customer: @customer_2)
    @invoice_4.items << @item_5
    @invoice_4.items << @item_7
    @invoice_item_1 = create(:invoice_item, item: @item_2, invoice: @invoice_2)
  end

  describe '/merchants/merchant_id/invoices' do
    it 'shows all invoices that include at least one of my merchant items and their id' do
      visit merchant_invoices_path(@merchant_2)

      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_3.id)
      expect(page).to_not have_content(@invoice_1.id)
    end

    it 'shows ids that link to the merchant invoice show page' do

      visit merchant_invoices_path(@merchant_2)
      
      expect(page).to have_link("Invoice #{@invoice_2.id}")
      click_link "Invoice #{@invoice_2.id}"
      expect(page).to have_current_path("/merchants/#{@merchant_2.id}/invoices/#{@invoice_2.id}") 
      expect(page).to have_content("Invoice #: #{@invoice_2.id}")
      expect(page).to_not have_content("Invoice #: #{@invoice_3.id}")
    end
  end
end