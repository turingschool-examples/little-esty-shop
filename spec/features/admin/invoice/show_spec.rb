require 'rails_helper'

RSpec.describe 'admin/invoices/invoice.id' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Marvel', status: 'enabled')
    @merchant_2 = Merchant.create!(name: 'D.C.', status: 'disabled')
    
    @discount_1 = BulkDiscount.create!(percentage: 15, quantity_threshold: 5, merchant_id: @merchant_1.id)
    @discount_2 = BulkDiscount.create!(percentage: 20, quantity_threshold: 10, merchant_id: @merchant_1.id)
    @discount_3 = BulkDiscount.create!(percentage: 10, quantity_threshold: 2, merchant_id: @merchant_2.id)
    
    @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker')
    @customer2 = Customer.create!(first_name: 'Clark', last_name: 'Kent') 
    
    @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: Time.parse('21.01.28'))
    @invoice2 = Invoice.create!(status: 'completed', customer_id: @customer2.id, created_at: Time.parse('22.08.22'))
    
    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant_1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: @merchant_2.id)
    
    @invoice_item_1 = InvoiceItem.create!(quantity: 5, unit_price: 500, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice2.id)
    
    @invoice_item_3 = InvoiceItem.create!(quantity: 50, unit_price: 5000, status: 'shipped', item_id: @item2.id, invoice_id: @invoice1.id)
    @invoice_item_4 = InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item2.id, invoice_id: @invoice2.id)
    
    @transaction1 = Transaction.create!(credit_card_number: '4801647818676136', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice1.id)
    @transaction3 = Transaction.create!(credit_card_number: '4800749911485986', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice2.id)
  end

  describe 'invoice show, has invoice info, invoice items info, and total revenue' do
    it 'shows related information to a specific invoice' do
      visit "/admin/invoices/#{@invoice1.id}"

      expect(page).to have_content("Id: #{@invoice1.id}")
      expect(page).to have_content('Status: completed')
      expect(page).to have_content('Created at: Thursday, January 28, 2021')
      expect(page).to have_content('Customer Name: Peter Parker')
    end

    it 'shows all items on the invoice including item name, quantity, price, status' do
      visit "/admin/invoices/#{@invoice1.id}"
      
      within("#item-#{@invoice_item_1.id}") do
        expect(page).to have_content('Item Name: Beanie Babies')
        expect(page).to have_content('Unit Price: 500')
        expect(page).to have_content('Quantity: 5')
        expect(page).to have_content('Status: packaged')
      end

      within("#item-#{@invoice_item_3.id}") do
        expect(page).to have_content('Item Name: Bat-A-Rangs')
        expect(page).to have_content('Unit Price: 5000')
        expect(page).to have_content('Quantity: 50')
        expect(page).to have_content('Status: shipped')
      end
    end

    it 'has the total revenue that will be generated from this invoice' do
      visit "/admin/invoices/#{@invoice1.id}"

      expect(page).to have_content('Total Revenue of All Items: 252500')
    end

    it 'can update invoice status from a select field' do
      visit "/admin/invoices/#{@invoice1.id}"
      
      choose(:status, option: 'in progress')
      click_on 'Update Invoice Status'
      
      expect(page).to have_content('Status: in progress')
    end
  end
end
