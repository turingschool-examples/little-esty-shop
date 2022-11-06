require 'rails_helper'

RSpec.describe 'Merchants Dashboard Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel')
    @merchant2 = Merchant.create!(name: 'D.C.')
    @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker')
    @customer2 = Customer.create!(first_name: 'Clark', last_name: 'Kent')
    @customer3 = Customer.create!(first_name: 'Louis', last_name: 'Lane')
    @customer4 = Customer.create!(first_name: 'Lex', last_name: 'Luther')
    @customer5 = Customer.create!(first_name: 'Frank', last_name: 'Castle')
    @customer6 = Customer.create!(first_name: 'Matt', last_name: 'Murdock')
    @customer7 = Customer.create!(first_name: 'Bruce', last_name: 'Wayne')
    @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id)
    @invoice2 = Invoice.create!(status: 'completed', customer_id: @customer2.id)
    @invoice3 = Invoice.create!(status: 'completed', customer_id: @customer3.id)
    @invoice4 = Invoice.create!(status: 'canceled', customer_id: @customer4.id)
    @invoice5 = Invoice.create!(status: 'completed', customer_id: @customer5.id)
    @invoice6 = Invoice.create!(status: 'completed', customer_id: @customer6.id)
    @invoice7 = Invoice.create!(status: 'completed', customer_id: @customer7.id)
    @invoice8 = Invoice.create!(status: 'completed', customer_id: @customer1.id)
    @invoice9 = Invoice.create!(status: 'completed', customer_id: @customer2.id)
    @invoice10 = Invoice.create!(status: 'completed', customer_id: @customer2.id)
    @invoice11 = Invoice.create!(status: 'completed', customer_id: @customer3.id)
    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: @merchant2.id)
    InvoiceItem.create!(quantity: 5, unit_price: 500, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
    InvoiceItem.create!(quantity: 1, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice2.id)
    InvoiceItem.create!(quantity: 6, unit_price: 600, status: 'pending', item_id: @item1.id, invoice_id: @invoice3.id)
    InvoiceItem.create!(quantity: 12, unit_price: 1200, status: 'packaged', item_id: @item1.id, invoice_id: @invoice4.id)
    InvoiceItem.create!(quantity: 8, unit_price: 800, status: 'packaged', item_id: @item1.id, invoice_id: @invoice5.id)
    InvoiceItem.create!(quantity: 20, unit_price: 2000, status: 'packaged', item_id: @item1.id, invoice_id: @invoice6.id)
    InvoiceItem.create!(quantity: 50, unit_price: 5000, status: 'shipped', item_id: @item2.id, invoice_id: @invoice7.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item2.id, invoice_id: @invoice8.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item1.id, invoice_id: @invoice9.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item1.id, invoice_id: @invoice10.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item1.id, invoice_id: @invoice11.id)
    @transaction1 = Transaction.create!(credit_card_number: '4801647818676136', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice1.id)
    @transaction3 = Transaction.create!(credit_card_number: '4800749911485986', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice2.id)
    @transaction4 = Transaction.create!(credit_card_number: '4923661117104166', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice3.id)
    @transaction5 = Transaction.create!(credit_card_number: '4536896899874279', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice4.id)
    @transaction6 = Transaction.create!(credit_card_number: '4536896899874280', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice4.id)
    @transaction7 = Transaction.create!(credit_card_number: '4536896899874281', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice5.id)
    @transaction8 = Transaction.create!(credit_card_number: '4536896899874286', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice6.id)
    @transaction9 = Transaction.create!(credit_card_number: '4636896899874290', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice6.id)
    @transaction10 = Transaction.create!(credit_card_number: '4636896899874291', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice7.id)
    @transaction11 = Transaction.create!(credit_card_number: '4636896899874298', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice8.id)
    @transaction12 = Transaction.create!(credit_card_number: '4636896899878732', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice9.id)
    @transaction13 = Transaction.create!(credit_card_number: '4636896899878732', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice10.id)
    @transaction14 = Transaction.create!(credit_card_number: '4636896899845752', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice11.id)
  end

  describe 'when I visit the merchant dashboard' do
    it 'sees the name of my merchant' do
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(current_path).to eq("/merchants/#{@merchant1.id}/dashboard")
      expect(page).to have_content('Marvel')
      expect(page).to_not have_content('D.C.')
    end

    it 'sees a link to my merchant items index' do
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(page).to have_link('My Items')
      click_on('My Items')

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
    end

    it 'sees a link to my merchant invoices index' do
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(page).to have_link('My Invoices')
      click_on('My Invoices')

      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
    end

    describe 'favorite customers' do
      it 'sees the names of the top 5 customers that conduct the largest number of successful transactions with merchants' do
        visit "/merchants/#{@merchant1.id}/dashboard"
        within('#top_customers') do
          expect(@customer2.full_name).to appear_before(@customer3.full_name)
          expect(@customer3.full_name).to appear_before(@customer1.full_name)
          expect(@customer1.full_name).to appear_before(@customer5.full_name)
          expect(@customer5.full_name).to appear_before(@customer6.full_name)
          expect(page).to have_content(@customer6.full_name)
        end
      end

      it 'has the number of successful transactions with the merchant next to each customer' do
        visit "/merchants/#{@merchant1.id}/dashboard"
        within('#top_customers') do
          expect(page).to have_content("#{@customer2.full_name} - Successful transactions: 3")
          expect(page).to have_content("#{@customer3.full_name} - Successful transactions: 2")
          expect(page).to have_content("#{@customer1.full_name} - Successful transactions: 1")
          expect(page).to have_content("#{@customer5.full_name} - Successful transactions: 1")
          expect(page).to have_content("#{@customer6.full_name} - Successful transactions: 1")
        end
      end
    end

    describe 'items ready to ship' do
      it 'has a section with list of names of items that have not yet shipped with a link to their merchant invoice show page' do
        visit "/merchants/#{@merchant1.id}/dashboard"

        within('#items_ready_to_ship') do
          expect(page).to have_content(@item1.name)
          expect(page).to have_content(@invoice1.id)
          expect(page).to have_content(@invoice3.id)
          expect(page).to have_content(@invoice4.id)
          expect(page).to have_content(@invoice5.id)
          expect(page).to have_content(@invoice6.id)
          expect(page).to_not have_content(@invoice2.id)
          expect(page).to have_link(@invoice1.id.to_s)
          expect(page).to have_link(@invoice3.id.to_s)
          expect(page).to have_link(@invoice4.id.to_s)
          expect(page).to have_link(@invoice5.id.to_s)
          expect(page).to have_link(@invoice6.id.to_s)
        end

        click_on(@invoice1.id.to_s)

        expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
      end

      it 'has the date of each item ready to ship from oldest to newest' do
        visit "/merchants/#{@merchant1.id}/dashboard"

        within('#items_ready_to_ship') do
          expect(page).to have_content(@invoice1.created_at.strftime('%A, %B%e, %Y'))
          expect(page).to have_content(@invoice3.created_at.strftime('%A, %B%e, %Y'))
          expect(page).to have_content(@invoice4.created_at.strftime('%A, %B%e, %Y'))
          expect(page).to have_content(@invoice5.created_at.strftime('%A, %B%e, %Y'))
          expect(page).to have_content(@invoice6.created_at.strftime('%A, %B%e, %Y'))
          expect("#{@invoice1.id}").to appear_before("#{@invoice3.id}")
          expect("#{@invoice3.id}").to appear_before("#{@invoice4.id}")
          expect("#{@invoice4.id}").to appear_before("#{@invoice5.id}")
          expect("#{@invoice5.id}").to appear_before("#{@invoice6.id}")
        end
      end
    end
  end
end
