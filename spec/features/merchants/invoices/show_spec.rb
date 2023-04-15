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

  describe 'User Story 16' do
    it 'Then I see all of my items on the invoice (Item Name, Invoice Item Quantity, Invoice Item Price, Invoice Item Status)' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      within '#items_table' do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@invoice_item_1.quantity)
        expect(page).to have_content(@invoice_item_1.unit_price)

        expect(page).to have_content(@item_7.name)
        expect(page).to have_content(@invoice_item_7.quantity)
        expect(page).to have_content(@invoice_item_7.unit_price)
      end

      visit merchant_invoice_path(@merchant_2, @invoice_7)

      within '#items_table' do
        expect(page).to have_content(@item_14.name)
        expect(page).to have_content(@invoice_item_27.quantity)
        expect(page).to have_content(@invoice_item_27.unit_price)
      end
    end
  end

  describe 'User Story 17' do
    it 'I see the total revenue that will be generated from this invoice' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)
    
      within "#invoice_info" do
        expect(page).to have_content(@invoice_1.total_revenue)
      end

      visit merchant_invoice_path(@merchant_2, @invoice_7)
      
      within "#invoice_info" do
        expect(page).to have_content(@invoice_7.total_revenue)
      end
    end
  end

  describe 'User Story 18' do
    it 'I see that the invoice status is a select field' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)
      
      within "#items_table" do
        expect(page).to have_select('invoice_item_status')
        expect(page).to have_button('Update Status')
      end
    end
    
    it 'I can update the invoice item status' do
      visit merchant_invoice_path(@merchant_1, @invoice_1)
      
      within "#item-#{@invoice_item_1.id}-status" do
        select 'Shipped', from: 'invoice_item_status'
        click_button 'Update Status'
      end

      @invoice_item_1.reload

      expect(@invoice_item_1.status).to eq('shipped')
      expect(current_path).to eq(merchant_invoice_path(@merchant_1, @invoice_1))

      within "#item-#{@invoice_item_21.id}-status" do
        select 'Pending', from: 'invoice_item_status'
        click_button 'Update Status'
      end

      @invoice_item_21.reload
      
      expect(@invoice_item_21.status).to eq('pending')
      expect(current_path).to eq(merchant_invoice_path(@merchant_1, @invoice_1))
    end
  end
end