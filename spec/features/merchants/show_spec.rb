require 'rails_helper'

RSpec.describe 'Merchants Dashboard Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel')
    @merchant2 = Merchant.create!(name: 'D.C.')
    @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker') # 1/1
    @customer2 = Customer.create!(first_name: 'Clark', last_name: 'Kent') # 3/0
    @customer3 = Customer.create!(first_name: 'Louis', last_name: 'Lane') # 2/0
    @customer4 = Customer.create!(first_name: 'Lex', last_name: 'Luther') # 0/0
    @customer5 = Customer.create!(first_name: 'Frank', last_name: 'Castle') # 1/0
    @customer6 = Customer.create!(first_name: 'Matt', last_name: 'Murdock') # 1/0
    @customer7 = Customer.create!(first_name: 'Bruce', last_name: 'Wayne') # 0/1
    @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id) # marvel
    @invoice2 = Invoice.create!(status: 'completed', customer_id: @customer2.id) # marvel
    @invoice3 = Invoice.create!(status: 'completed', customer_id: @customer3.id) # marvel
    @invoice4 = Invoice.create!(status: 'canceled', customer_id: @customer4.id) # marvel
    @invoice5 = Invoice.create!(status: 'completed', customer_id: @customer5.id) # marvel
    @invoice6 = Invoice.create!(status: 'completed', customer_id: @customer6.id) # marvel
    @invoice7 = Invoice.create!(status: 'completed', customer_id: @customer7.id) # D.C.
    @invoice8 = Invoice.create!(status: 'completed', customer_id: @customer1.id) # D.C.
    @invoice9 = Invoice.create!(status: 'completed', customer_id: @customer2.id) # marvel
    @invoice10 = Invoice.create!(status: 'completed', customer_id: @customer2.id) # marvel
    @invoice11 = Invoice.create!(status: 'completed', customer_id: @customer3.id) # marvel
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

      xit 'has the number of successful transactions with the merchant next to each customer' do
      end
    end
  end
end
