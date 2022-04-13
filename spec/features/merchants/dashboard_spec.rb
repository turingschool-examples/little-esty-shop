require 'rails_helper'

RSpec.describe 'merchant dashboard' do

  before(:each) do
    @merchant = Merchant.create!(name: 'Brylan')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    @invoice_1 = @customer_1.invoices.create!(status: 'completed')
    @item_1 = @merchant.items.create!(name: 'Pencil', unit_price: 5, description: 'Writes things.')
    @item_1.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 3, unit_price: 4, status: 2)
    @invoice_1.transactions.create!(credit_card_number: '4654405418249632', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249631', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249633', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')

    @customer_2 = Customer.create!(first_name: 'Osinski', last_name: 'Cecelia')
    @invoice_2 = @customer_2.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_2.id, quantity: 3, unit_price: 4, status: 2)
    @invoice_2.transactions.create!(credit_card_number: '5654405418249632', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249631', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')

    @customer_3 = Customer.create!(first_name: 'Toy', last_name: 'Mariah')
    @invoice_3 = @customer_3.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_3.id, quantity: 3, unit_price: 4, status: 2)
    @invoice_3.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')

    @customer_4 = Customer.create!(first_name: 'Joy', last_name: 'Braun')
    @invoice_4 = @customer_4.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_4.id, quantity: 3, unit_price: 4, status: 2)
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

    @customer_5 = Customer.create!(first_name: 'Mark', last_name: 'Brains')
    @invoice_5 = @customer_5.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_5.id, quantity: 3, unit_price: 4, status: 2)
    @invoice_5.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_5.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

    @customer_6 = Customer.create!(first_name: 'Smark', last_name: 'Mrains')
    @invoice_6 = @customer_6.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_6.id, quantity: 3, unit_price: 4, status: 2)
    @invoice_6.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

    visit "/merchants/#{@merchant.id}/dashboard"
  end

  it 'displays the name of the merchant' do
    expect(page).to have_content('Brylan')
  end

  context 'links' do
    it 'displays links to the merchant items index' do
      click_link "Merchant's Items"
      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    end

    it 'displays links to the merchant invoices index' do
      click_link "Merchant's Invoices"
      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
    end
  end

  context 'dashboard statistics' do

    it 'displays the top 5 customers based on transactions' do
      within '#statistics' do
        expect("Joey Ondricka").to appear_before("Osinski Cecelia")
        expect("Osinski Cecelia").to appear_before("Toy Mariah")
        expect("Toy Mariah").to appear_before("Joy Braun")
        expect("Joy Braun").to appear_before("Mark Brains")
        expect("Mark Brains").to_not appear_before("Joy Braun")
      end
    end

    it 'displays the number of successful transactions next to customer' do
      within "#customer-#{@customer_1.id}" do
        expect(page).to have_content('Succesful Transactions: 6')
      end

      within "#customer-#{@customer_2.id}" do
        expect(page).to have_content('Succesful Transactions: 5')
      end

      within "#customer-#{@customer_3.id}" do
        expect(page).to have_content('Succesful Transactions: 4')
      end

      within "#customer-#{@customer_4.id}" do
        expect(page).to have_content('Succesful Transactions: 3')
      end

      within "#customer-#{@customer_5.id}" do
        expect(page).to have_content('Succesful Transactions: 2')
      end
    end
  end
end
