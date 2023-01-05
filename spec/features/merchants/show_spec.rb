require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Schroeder-Jerde')
    @merchant_2 = Merchant.create!(name: 'Rempel and Jones')
    @merchant_3 = Merchant.create!(name: 'Willms and Sons')

    @item_1 = @merchant_1.items.create!(name: 'Qui Esse', description: 'Nihil autem sit odio inventore deleniti', unit_price: 75107)
    @item_2 = @merchant_1.items.create!(name: 'Autem Minima', description: 'Cumque consequuntur ad', unit_price: 67076)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    @customer_2 = Customer.create!(first_name: 'Cecelia', last_name: 'Osinski')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Toy')
    @customer_4 = Customer.create!(first_name: 'Leanna', last_name: 'Braun')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Heber', last_name: 'Kuhn')
    @customer_7 = Customer.create!(first_name: 'Parker', last_name: 'Daugherty')
    @customer_8 = Customer.create!(first_name: 'Loyal', last_name: 'Considine')
    @customer_9 = Customer.create!(first_name: 'Dejon', last_name: 'Fadel')
    @customer_10 = Customer.create!(first_name: 'Ramona', last_name: 'Reynolds')

    @invoice_1 = @customer_1.invoices.create!(status: 'cancelled')
    @invoice_2 = @customer_1.invoices.create!(status: 'cancelled')
    @invoice_3 = @customer_2.invoices.create!(status: 'completed')
    @invoice_4 = @customer_2.invoices.create!(status: 'in progress')
    @invoice_5 = @customer_2.invoices.create!(status: 'cancelled')
    @invoice_6 = @customer_3.invoices.create!(status: 'in progress')
    @invoice_7 = @customer_3.invoices.create!(status: 'in progress')
    @invoice_8 = @customer_3.invoices.create!(status: 'cancelled')
    @invoice_9 = @customer_3.invoices.create!(status: 'completed')
    @invoice_10 = @customer_6.invoices.create!(status: 'completed')
    @invoice_11 = @customer_5.invoices.create!(status: 'in progress')
    @invoice_12 = @customer_3.invoices.create!(status: 'completed')
    @invoice_13 = @customer_4.invoices.create!(status: 'completed')
    @invoice_14 = @customer_2.invoices.create!(status: 'completed')
    @invoice_15 = @customer_3.invoices.create!(status: 'completed')
    @invoice_16 = @customer_3.invoices.create!(status: 'completed')
    @invoice_17 = @customer_4.invoices.create!(status: 'completed')
    @invoice_18 = @customer_4.invoices.create!(status: 'in progress')
    @invoice_19 = @customer_4.invoices.create!(status: 'in progress')
    @invoice_20 = @customer_5.invoices.create!(status: 'completed')
    @invoice_21 = @customer_4.invoices.create!(status: 'in progress')

    InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 5, unit_price: 13635, status: 'packaged')
    InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 9, unit_price: 23324, status: 'pending')
    InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_1.id, quantity: 12, unit_price: 34873, status: 'packaged')
    InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_1.id, quantity: 8, unit_price: 2196, status: 'pending')
    InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_1.id, quantity: 3, unit_price: 79140, status: 'packaged')
    InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_1.id, quantity: 9, unit_price: 52100, status: 'shipped')
    InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_1.id, quantity: 10, unit_price: 66747, status: 'shipped')
    InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_2.id, quantity: 9, unit_price: 76941, status: 'packaged')
    InvoiceItem.create!(invoice_id: @invoice_9.id, item_id: @item_2.id, quantity: 3, unit_price: 79140, status: 'packaged')
    InvoiceItem.create!(invoice_id: @invoice_10.id, item_id: @item_2.id, quantity: 9, unit_price: 52100, status: 'shipped')
    InvoiceItem.create!(invoice_id: @invoice_11.id, item_id: @item_2.id, quantity: 10, unit_price: 66747, status: 'shipped')
    InvoiceItem.create!(invoice_id: @invoice_12.id, item_id: @item_2.id, quantity: 9, unit_price: 76941, status: 'packaged')
    InvoiceItem.create!(invoice_id: @invoice_13.id, item_id: @item_2.id, quantity: 9, unit_price: 76941, status: 'packaged')
    InvoiceItem.create!(invoice_id: @invoice_14.id, item_id: @item_2.id, quantity: 9, unit_price: 76941, status: 'packaged')
    InvoiceItem.create!(invoice_id: @invoice_15.id, item_id: @item_2.id, quantity: 9, unit_price: 76941, status: 'packaged')
    InvoiceItem.create!(invoice_id: @invoice_16.id, item_id: @item_2.id, quantity: 9, unit_price: 76941, status: 'packaged')
    InvoiceItem.create!(invoice_id: @invoice_17.id, item_id: @item_2.id, quantity: 9, unit_price: 76941, status: 'packaged')
    InvoiceItem.create!(invoice_id: @invoice_18.id, item_id: @item_2.id, quantity: 9, unit_price: 76941, status: 'packaged')
    InvoiceItem.create!(invoice_id: @invoice_19.id, item_id: @item_2.id, quantity: 9, unit_price: 76941, status: 'packaged')
    InvoiceItem.create!(invoice_id: @invoice_20.id, item_id: @item_2.id, quantity: 9, unit_price: 76941, status: 'packaged')
    InvoiceItem.create!(invoice_id: @invoice_21.id, item_id: @item_2.id, quantity: 9, unit_price: 76941, status: 'packaged')

    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: '04/22/20', result: 'failed')
    @transaction_2 = @invoice_2.transactions.create!(credit_card_number: '4580251236515201', credit_card_expiration_date: '03/22/20', result: 'failed')
    @transaction_3 = @invoice_3.transactions.create!(credit_card_number: '4354495077693036', credit_card_expiration_date: '09/22/20', result: 'success')
    @transaction_4 = @invoice_4.transactions.create!(credit_card_number: '4515551623735607', credit_card_expiration_date: '08/22/20', result: 'success')
    @transaction_5 = @invoice_5.transactions.create!(credit_card_number: '4844518708741275', credit_card_expiration_date: '10/22/20', result: 'failed')
    @transaction_6 = @invoice_6.transactions.create!(credit_card_number: '4203696133194408', credit_card_expiration_date: '02/22/20', result: 'success')
    @transaction_7 = @invoice_7.transactions.create!(credit_card_number: '4801647818676136', credit_card_expiration_date: '01/22/20', result: 'success')
    @transaction_8 = @invoice_8.transactions.create!(credit_card_number: '4540842003561938', credit_card_expiration_date: '09/22/20', result: 'failed')
    @transaction_9 = @invoice_9.transactions.create!(credit_card_number: '4140149827486249', credit_card_expiration_date: '10/22/20', result: 'success')
    @transaction_10 = @invoice_10.transactions.create!(credit_card_number: '4923661117104166', credit_card_expiration_date: '08/22/20', result: 'success')
    @transaction_11 = @invoice_11.transactions.create!(credit_card_number: '4923661117104166', credit_card_expiration_date: '08/22/20', result: 'success')
    @transaction_12 = @invoice_12.transactions.create!(credit_card_number: '4017503416578382', credit_card_expiration_date: '08/22/20', result: 'success')
    @transaction_13 = @invoice_13.transactions.create!(credit_card_number: '9856503416578382', credit_card_expiration_date: '08/25/20', result: 'success')
    @transaction_14 = @invoice_14.transactions.create!(credit_card_number: '6565503416578382', credit_card_expiration_date: '08/29/20', result: 'success')
    @transaction_15 = @invoice_15.transactions.create!(credit_card_number: '6225503416578382', credit_card_expiration_date: '08/29/20', result: 'success')
    @transaction_16 = @invoice_16.transactions.create!(credit_card_number: '6965503416578382', credit_card_expiration_date: '08/29/20', result: 'success')
    @transaction_17 = @invoice_17.transactions.create!(credit_card_number: '6965503416578382', credit_card_expiration_date: '08/29/20', result: 'success')
    @transaction_18 = @invoice_18.transactions.create!(credit_card_number: '6965503416578382', credit_card_expiration_date: '08/29/20', result: 'success')
    @transaction_19 = @invoice_19.transactions.create!(credit_card_number: '6965503416578382', credit_card_expiration_date: '08/29/20', result: 'success')
    @transaction_20 = @invoice_20.transactions.create!(credit_card_number: '6965503416578382', credit_card_expiration_date: '08/29/20', result: 'success')
    @transaction_21 = @invoice_21.transactions.create!(credit_card_number: '6965503416578382', credit_card_expiration_date: '08/29/20', result: 'success')
  end
  
  # As a merchant,
  # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
  # Then I see the name of my merchant
  describe 'User story 1' do
    it 'can show the merchant name' do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      
      expect(page).to have_content(@merchant_1.name)
    end
  end

  describe 'User Story 2' do 
    it 'displays a link to merchant items index and merchant invoices index' do 
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_link("My Items")
      expect(page).to have_link("My Invoices")
      
      click_on "My Items"
      
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")      
      
      visit "/merchants/#{@merchant_1.id}/dashboard"
      
      click_on "My Invoices"

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")      
    end
  end

# As a merchant,
# When I visit my merchant dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions with my merchant
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant
  describe 'User Story 3' do
    it 'displays the top 5 customers (successful transactions)' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      within("#customer_#{@customer_2.id}") do
        expect(page).to have_content(@customer_2.full_name)
        expect(page).to_not have_content(@customer_3.full_name)
      end
      
      within("#customer_#{@customer_3.id}") do
        expect(page).to have_content(@customer_3.full_name)
        expect(page).to_not have_content(@customer_2.full_name)
      end
      
      within("#customer_#{@customer_4.id}") do
        expect(page).to have_content(@customer_4.full_name)
        expect(page).to_not have_content(@customer_2.full_name)
      end
      
      within("#customer_#{@customer_5.id}") do
        expect(page).to have_content(@customer_5.full_name)
        expect(page).to_not have_content(@customer_2.full_name)
      end
      
      within("#customer_#{@customer_6.id}") do
        expect(page).to have_content(@customer_6.full_name)
        expect(page).to_not have_content(@customer_2.full_name)
      end

      expect(page).to_not have_content(@customer_1.full_name)

    end

    it 'displays the number of successful transactions of each customer' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      within("#customer_#{@customer_2.id}") do
        expect(page).to have_content(@customer_2.full_name)
        expect(page).to have_content("#{@customer_2.successful_transaction_count} purchases")
        expect(page).to_not have_content(@customer_3.full_name)
      end
      
      within("#customer_#{@customer_3.id}") do
        expect(page).to have_content(@customer_3.full_name)
        expect(page).to have_content("#{@customer_3.successful_transaction_count} purchases")
        expect(page).to_not have_content(@customer_2.full_name)
      end
      
      within("#customer_#{@customer_4.id}") do
        expect(page).to have_content(@customer_4.full_name)
        expect(page).to have_content("#{@customer_4.successful_transaction_count} purchases")
        expect(page).to_not have_content(@customer_2.full_name)
      end
      
      within("#customer_#{@customer_5.id}") do
        expect(page).to have_content(@customer_5.full_name)
        expect(page).to have_content("#{@customer_5.successful_transaction_count} purchases")
        expect(page).to_not have_content(@customer_2.full_name)
      end
      
      within("#customer_#{@customer_6.id}") do
        expect(page).to have_content(@customer_6.full_name)
        expect(page).to have_content("#{@customer_6.successful_transaction_count} purchases")
        expect(page).to_not have_content(@customer_2.full_name)
      end
      
      expect(@customer_3.first_name).to appear_before(@customer_2.full_name)
      expect(@customer_4.first_name).to_not appear_before(@customer_3.full_name)
      expect(@customer_2.first_name).to appear_before(@customer_5.full_name)
    end
  end
end