require 'rails_helper'

RSpec.describe 'merchant dashboard' do

  before(:each) do
    @merchant = Merchant.create!(name: 'Brylan')
    @item_1 = @merchant.items.create!(name: 'Pencil', unit_price: 500, description: 'Writes things.')
    @item_2 = @merchant.items.create!(name: 'Pen', unit_price: 400, description: 'Writes things, but dark.')
    @item_3 = @merchant.items.create!(name: 'Marker', unit_price: 400, description: 'Writes things, but dark, and thicc.')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    @invoice_1 = @customer_1.invoices.create!(status: 'completed')
    @invoice_7 = @customer_1.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-03-27 14:54:09 UTC"))
    @item_2.invoice_items.create!(invoice_id: @invoice_7.id, quantity: 5, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-03-28 14:54:09 UTC"))
    @invoice_1.transactions.create!(credit_card_number: '4654405418249632', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249631', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249633', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')

    @customer_2 = Customer.create!(first_name: 'Osinski', last_name: 'Cecelia')
    @invoice_2 = @customer_2.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_2.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-03-29 14:54:09 UTC"))
    @invoice_2.transactions.create!(credit_card_number: '5654405418249632', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249631', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')

    @customer_3 = Customer.create!(first_name: 'Toy', last_name: 'Mariah')
    @invoice_3 = @customer_3.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_3.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-03-30 14:54:09 UTC"))
    @invoice_3.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')

    @customer_4 = Customer.create!(first_name: 'Joy', last_name: 'Braun')
    @invoice_4 = @customer_4.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_4.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-04-01 14:54:09 UTC"))
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

    @customer_5 = Customer.create!(first_name: 'Mark', last_name: 'Brains')
    @invoice_5 = @customer_5.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_5.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-04-02 14:54:09 UTC"))
    @invoice_5.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_5.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

    @customer_6 = Customer.create!(first_name: 'Smark', last_name: 'Mrains')
    @invoice_6 = @customer_6.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_6.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-04-03 14:54:09 UTC"))
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

    it 'displays the number of successful transactions next to each customer' do
      within "#customer-#{@customer_1.id}" do
        expect(page).to have_content('Successful Transactions: 6')
      end

      within "#customer-#{@customer_2.id}" do
        expect(page).to have_content('Successful Transactions: 5')
      end

      within "#customer-#{@customer_3.id}" do
        expect(page).to have_content('Successful Transactions: 4')
      end

      within "#customer-#{@customer_4.id}" do
        expect(page).to have_content('Successful Transactions: 3')
      end

      within "#customer-#{@customer_5.id}" do
        expect(page).to have_content('Successful Transactions: 2')
      end
    end


    it 'displays the names of all items that are ready to ship' do
      within '#items-ready-to-ship' do
        expect(page).to have_content("Pencil")
        expect(page).to have_content("Pen")
        expect(page).to_not have_content("Marker")
      end
    end

    it 'each item has its invoice id as link to its invoice show page' do
      within "#item-#{@item_1.id}" do
        click_link "#{@invoice_1.id}"
      end
      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")

      visit "/merchants/#{@merchant.id}/dashboard"

      within "#item-#{@item_1.id}" do
        expect(page).to have_link("#{@invoice_2.id}")
        expect(page).to have_link("#{@invoice_3.id}")
        expect(page).to have_link("#{@invoice_4.id}")
        expect(page).to have_link("#{@invoice_5.id}")
        expect(page).to have_link("#{@invoice_6.id}")
        expect(page).to_not have_link("#{@invoice_7.id}")
      end

      within "#item-#{@item_2.id}" do
        click_link "#{@invoice_7.id}"
      end
      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_7.id}")
    end

    it 'invoices have formatted date of creation and are ordered from oldest to newest' do
      within "#item-#{@item_1.id}" do
        expect(page).to have_content("Tuesday, March 27, 2012")
        expect(page).to have_content("Thursday, March 29, 2012")
        expect(page).to have_content("Friday, March 30, 2012")
        expect(page).to have_content("Sunday, April 01, 2012")
        expect(page).to_not have_content("Wednesday, March 28, 2012")
      end

      within "#item-#{@item_1.id}" do
        expect("#{@invoice_1.id}").to appear_before("#{@invoice_2.id}")
        expect("#{@invoice_2.id}").to appear_before("#{@invoice_3.id}")
        expect("#{@invoice_3.id}").to appear_before("#{@invoice_4.id}")
        expect("#{@invoice_4.id}").to appear_before("#{@invoice_5.id}")
        expect("#{@invoice_5.id}").to appear_before("#{@invoice_6.id}")
      end
    end
  end
end
