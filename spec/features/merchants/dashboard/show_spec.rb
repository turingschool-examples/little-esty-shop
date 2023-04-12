require 'rails_helper'

RSpec.describe 'Merchant Dashboard Show Page' do
 before(:each) do
  test_data
 end

  describe 'As a merchant' do
    it 'I can see my merchant dashboard' do
      visit dashboard_merchant_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)

      visit dashboard_merchant_path(@merchant_2)

      expect(page).to have_content(@merchant_2.name)
    end
  end

  describe 'As a merchant' do
    it 'I see a link to my merchant items index' do
      visit dashboard_merchant_path(@merchant_1)
      
      within '#links' do
        expect(page).to have_link('My Items')
      end

      visit dashboard_merchant_path(@merchant_2)

      within '#links' do
        expect(page).to have_link('My Items')
      end
    end

    it 'I see a link to my merchant invoices index' do
      visit dashboard_merchant_path(@merchant_1)
      
      within '#links' do
        expect(page).to have_link('My Invoices')
      end

      visit dashboard_merchant_path(@merchant_2)

      within '#links' do
        expect(page).to have_link('My Invoices')
      end
    end
  end

  describe 'As a merchant' do
    it 'I see the names of the top 5 customers' do
      visit dashboard_merchant_path(@merchant_1)
      
      within '#top_customers' do
        expect(@customer_6.last_name).to appear_before(@customer_5.last_name)
        expect(@customer_5.last_name).to appear_before(@customer_1.last_name)
        expect(@customer_1.last_name).to appear_before(@customer_2.last_name)
        expect(@customer_2.last_name).to appear_before(@customer_3.last_name)
      end
      @invoice_21 = Invoice.create!(customer_id: @customer_5.id, status: 1)
      @invoice_22 = Invoice.create!(customer_id: @customer_5.id, status: 1)
      @invoice_23 = Invoice.create!(customer_id: @customer_5.id, status: 1)
      @invoice_24 = Invoice.create!(customer_id: @customer_5.id, status: 1)
      @invoice_25 = Invoice.create!(customer_id: @customer_5.id, status: 1)
      @invoice_item_21 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_21.id, quantity: 1, unit_price: 100, status: 1)
      @invoice_item_22 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_22.id, quantity: 1, unit_price: 100, status: 1)
      @invoice_item_23 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_23.id, quantity: 1, unit_price: 100, status: 1)
      @invoice_item_24 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_24.id, quantity: 1, unit_price: 100, status: 1)
      @invoice_item_25 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_25.id, quantity: 1, unit_price: 100, status: 1)
      @transaction_21 = Transaction.create!(invoice_id: @invoice_21.id, credit_card_number: 1234567890123456, credit_card_expiration_date: 2020-01-01, result: 1)
      @transaction_22 = Transaction.create!(invoice_id: @invoice_22.id, credit_card_number: 1234567890123456, credit_card_expiration_date: 2020-01-01, result: 1)
      @transaction_23 = Transaction.create!(invoice_id: @invoice_23.id, credit_card_number: 1234567890123456, credit_card_expiration_date: 2020-01-01, result: 1)
      @transaction_24 = Transaction.create!(invoice_id: @invoice_24.id, credit_card_number: 1234567890123456, credit_card_expiration_date: 2020-01-01, result: 1)
      @transaction_25 = Transaction.create!(invoice_id: @invoice_25.id, credit_card_number: 1234567890123456, credit_card_expiration_date: 2020-01-01, result: 1)

      visit dashboard_merchant_path(@merchant_1)
      save_and_open_page
      within '#top_customers' do
        expect(@customer_5.last_name).to appear_before(@customer_6.last_name)
        expect(@customer_6.last_name).to appear_before(@customer_1.last_name)
      end
    end
    
  end
end

# As a merchant,
# When I visit my merchant dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions with my merchant
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant