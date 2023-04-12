require 'rails_helper'

RSpec.describe 'Merchant Dashboard Show Page' do
 before(:each) do
  @merchant_1 = FactoryBot.create(:merchant)
  @merchant_2 = FactoryBot.create(:merchant)
  @merchant_3 = FactoryBot.create(:merchant)
  @item_1 = @merchant_1.items.create!(name: 'Item 1', description: 'Description 1', unit_price: 1)
  @item_2 = @merchant_1.items.create!(name: 'Item 2', description: 'Description 2', unit_price: 2)
  @item_3 = @merchant_2.items.create!(name: 'Item 3', description: 'Description 3', unit_price: 3)
  @item_4 = @merchant_2.items.create!(name: 'Item 4', description: 'Description 4', unit_price: 4)
  @item_5 = @merchant_3.items.create!(name: 'Item 5', description: 'Description 5', unit_price: 5)
  @customer_1 = Customer.create!(first_name: 'Customer', last_name: 'One')
  @customer_2 = Customer.create!(first_name: 'Customer', last_name: 'Two')
  @customer_3 = Customer.create!(first_name: 'Customer', last_name: 'Three')
  @customer_4 = Customer.create!(first_name: 'Customer', last_name: 'Four')
  @customer_5 = Customer.create!(first_name: 'Customer', last_name: 'Five')
  @customer_6 = Customer.create!(first_name: 'Customer', last_name: 'Six')
  @invoice_1 = @customer_1.invoices.create!(status: 1)
  @invoice_2 = @customer_1.invoices.create!(status: 1)
  @invoice_3 = @customer_1.invoices.create!(status: 1)
  @invoice_4 = @customer_2.invoices.create!(status: 1)
  @invoice_5 = @customer_2.invoices.create!(status: 1)
  @invoice_6 = @customer_3.invoices.create!(status: 1)
  @invoice_7 = @customer_3.invoices.create!(status: 1)
  @invoice_8 = @customer_4.invoices.create!(status: 1)
  @invoice_9 = @customer_4.invoices.create!(status: 1)
  @invoice_10 = @customer_5.invoices.create!(status: 1)
  @invoice_11 = @customer_5.invoices.create!(status: 1)
  @invoice_12 = @customer_5.invoices.create!(status: 1)
  @invoice_13 = @customer_5.invoices.create!(status: 1)
  @invoice_14 = @customer_6.invoices.create!(status: 1)
  @invoice_15 = @customer_6.invoices.create!(status: 1)
  @invoice_16 = @customer_6.invoices.create!(status: 1)
  @invoice_17 = @customer_6.invoices.create!(status: 1)
  @invoice_18 = @customer_6.invoices.create!(status: 1)
  @invoice_19 = @customer_6.invoices.create!(status: 1)
  @invoice_20 = @customer_6.invoices.create!(status: 1)
  @invoice_item_1 = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1, status: 1)
  @invoice_item_2 = @invoice_2.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1, status: 1)
  @invoice_item_3 = @invoice_3.invoice_items.create!(item: @item_1, quantity: 3, unit_price: 1, status: 1)
  @invoice_item_4 = @invoice_4.invoice_items.create!(item: @item_1, quantity: 4, unit_price: 1, status: 1)
  @invoice_item_5 = @invoice_5.invoice_items.create!(item: @item_1, quantity: 5, unit_price: 1, status: 1)
  @invoice_item_6 = @invoice_6.invoice_items.create!(item: @item_1, quantity: 6, unit_price: 1, status: 1)
  @invoice_item_7 = @invoice_7.invoice_items.create!(item: @item_1, quantity: 7, unit_price: 1, status: 1)
  @invoice_item_8 = @invoice_8.invoice_items.create!(item: @item_1, quantity: 8, unit_price: 1, status: 1)
  @invoice_item_9 = @invoice_9.invoice_items.create!(item: @item_1, quantity: 9, unit_price: 1, status: 1)
  @invoice_item_10 = @invoice_10.invoice_items.create!(item: @item_1, quantity: 10, unit_price: 1, status: 1)
  @invoice_item_11 = @invoice_11.invoice_items.create!(item: @item_1, quantity: 11, unit_price: 1, status: 1)
  @invoice_item_12 = @invoice_12.invoice_items.create!(item: @item_1, quantity: 12, unit_price: 1, status: 1)
  @invoice_item_13 = @invoice_13.invoice_items.create!(item: @item_1, quantity: 13, unit_price: 1, status: 1)
  @invoice_item_14 = @invoice_14.invoice_items.create!(item: @item_1, quantity: 14, unit_price: 1, status: 1)
  @invoice_item_15 = @invoice_15.invoice_items.create!(item: @item_1, quantity: 15, unit_price: 1, status: 1)
  @invoice_item_16 = @invoice_16.invoice_items.create!(item: @item_1, quantity: 16, unit_price: 1, status: 1)
  @invoice_item_17 = @invoice_17.invoice_items.create!(item: @item_1, quantity: 17, unit_price: 1, status: 1)
  @invoice_item_18 = @invoice_18.invoice_items.create!(item: @item_1, quantity: 18, unit_price: 1, status: 1)
  @invoice_item_19 = @invoice_19.invoice_items.create!(item: @item_1, quantity: 19, unit_price: 1, status: 1)
  @invoice_item_20 = @invoice_20.invoice_items.create!(item: @item_1, quantity: 20, unit_price: 1, status: 1)
  @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_2 = @invoice_2.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_3 = @invoice_3.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_4 = @invoice_4.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_5 = @invoice_5.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_6 = @invoice_6.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_7 = @invoice_7.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_8 = @invoice_8.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_9 = @invoice_9.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_10 = @invoice_10.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_11 = @invoice_11.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_12 = @invoice_12.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_13 = @invoice_13.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_14 = @invoice_14.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_15 = @invoice_15.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_16 = @invoice_16.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_17 = @invoice_17.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_18 = @invoice_18.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_19 = @invoice_19.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
  @transaction_20 = @invoice_20.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
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
      save_and_open_page
    end
    
  end
end

# As a merchant,
# When I visit my merchant dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions with my merchant
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant