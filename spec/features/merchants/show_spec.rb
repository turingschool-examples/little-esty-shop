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
    @invoice4 = Invoice.create!(status: 'completed', customer_id: @customer4.id)
    @invoice5 = Invoice.create!(status: 'completed', customer_id: @customer5.id)
    @invoice6 = Invoice.create!(status: 'completed', customer_id: @customer6.id)
    @invoice7 = Invoice.create!(status: 'completed', customer_id: @customer7.id)
    @transaction1 = Transaction.create!(credit_card_number: '4801647818676136', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice1.id)
    @transaction3 = Transaction.create!(credit_card_number: '4800749911485986', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice2.id)
    @transaction4 = Transaction.create!(credit_card_number: '4017503416578382', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice2.id)
    @transaction5 = Transaction.create!(credit_card_number: '4923661117104166', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice3.id)
    @transaction6 = Transaction.create!(credit_card_number: '4536896812764278', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice3.id)
    @transaction7 = Transaction.create!(credit_card_number: '4536896899874278', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice3.id)
    @transaction8 = Transaction.create!(credit_card_number: '4536896899874279', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice4.id)
    @transaction9 = Transaction.create!(credit_card_number: '4536896899874280', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice4.id)
    @transaction10 = Transaction.create!(credit_card_number: '4536896899874281', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice5.id)
    @transaction11 = Transaction.create!(credit_card_number: '4536896899874282', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice5.id)
    @transaction12 = Transaction.create!(credit_card_number: '4536896899874283', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice5.id)
    @transaction13 = Transaction.create!(credit_card_number: '4536896899874284', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice5.id)
    @transaction14 = Transaction.create!(credit_card_number: '4536896899874285', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice5.id)
    @transaction15 = Transaction.create!(credit_card_number: '4536896899874286', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice6.id)
    @transaction16 = Transaction.create!(credit_card_number: '4636896899874287', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice6.id)
    @transaction17 = Transaction.create!(credit_card_number: '4636896899874288', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice6.id)
    @transaction18 = Transaction.create!(credit_card_number: '4636896899874289', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice6.id)
    @transaction19 = Transaction.create!(credit_card_number: '4636896899874290', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice6.id)
    @transaction20 = Transaction.create!(credit_card_number: '4636896899874291', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice7.id)
    @transaction21 = Transaction.create!(credit_card_number: '4636896899874292', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice7.id)
    @transaction22 = Transaction.create!(credit_card_number: '4636896899874293', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice7.id)
    @transaction23 = Transaction.create!(credit_card_number: '4636896899874294', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice7.id)
    @transaction24 = Transaction.create!(credit_card_number: '4636896899874295', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice7.id)
    @transaction25 = Transaction.create!(credit_card_number: '4636896899874296', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice7.id)
    @transaction26 = Transaction.create!(credit_card_number: '4636896899874297', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice7.id)
    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: @merchant2.id)
    InvoiceItem.create!(quantity: 5, unit_price: 500, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
    InvoiceItem.create!(quantity: 1, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice2.id)
    InvoiceItem.create!(quantity: 6, unit_price: 600, status: 'pending', item_id: @item1.id, invoice_id: @invoice3.id)
    InvoiceItem.create!(quantity: 12, unit_price: 1200, status: 'packaged', item_id: @item1.id, invoice_id: @invoice4.id)
    InvoiceItem.create!(quantity: 8, unit_price: 800, status: 'packaged', item_id: @item1.id, invoice_id: @invoice5.id)
    InvoiceItem.create!(quantity: 20, unit_price: 2000, status: 'packaged', item_id: @item1.id, invoice_id: @invoice6.id)
    InvoiceItem.create!(quantity: 50, unit_price: 5000, status: 'shipped', item_id: @item2.id, invoice_id: @invoice4.id)
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
          expect(@customer5.full_name).to appear_before(@customer6.full_name)
          expect(@customer6.full_name).to appear_before(@customer3.full_name)
          expect(@customer3.full_name).to appear_before(@customer2.full_name)
          expect(@customer2.full_name).to appear_before(@customer1.full_name)
          expect(page).to have_content(@customer1.full_name)
        end
      end

      xit 'has the number of successful transactions with the merchant next to each customer' do
      end
    end
  end
end
