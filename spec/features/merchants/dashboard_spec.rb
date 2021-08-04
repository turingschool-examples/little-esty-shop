require 'rails_helper'

RSpec.describe 'the merchant dashboard' do
  describe 'display' do
    it 'shows the name of the merchant and links to items and invoices index' do
      visit merchant_path(@merchant1.id)

      within('#header') do
        expect(page).to have_content(@merchant1.name)
        expect(page).to have_selector(:link_or_button, "My Invoices")
        expect(page).to have_selector(:link_or_button, "My Items")
      end
    end
  end

  describe 'hyperlinks' do
    it 'links to merchant invoice and items index' do
      visit merchant_path(@merchant1.id)

      within('#header') do
        click_link 'My Invoices'

        expect(current_path).to eq(merchant_invoices_path(@merchant1.id))
      end

      visit merchant_path(@merchant1.id)

      within('#header') do
        click_link 'My Items'

        expect(current_path).to eq(merchant_items_path(@merchant1.id))
      end
    end
  end

  describe 'favorite customers' do
    it 'shows favorite customers' do
      customer5 = Customer.create!(first_name: 'FName5', last_name: 'LName5')

      invoice16 = customer5.invoices.create!(status: 'completed')

      invoice_item17 = InvoiceItem.create!(invoice_id: invoice16.id, item_id: @item1.id, quantity: 100, unit_price: @item1.unit_price, status: 'packaged')

      transaction14 = invoice16.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction15 = invoice16.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction16 = invoice16.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction17 = invoice16.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction18 = invoice16.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)


      customer6 = Customer.create!(first_name: 'FName6', last_name: 'LName6')

      invoice17 = customer6.invoices.create!(status: 'in_progress')

      invoice_item18 = InvoiceItem.create!(invoice_id: invoice17.id, item_id: @item2.id, quantity: 100, unit_price: @item2.unit_price, status: 'packaged')

      transaction19 = invoice17.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction20 = invoice17.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction21 = invoice17.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction22 = invoice17.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)


      customer7 = Customer.create!(first_name: 'FName7', last_name: 'LName7')

      invoice18 = customer7.invoices.create!(status: 'in_progress')

      invoice_item19 = InvoiceItem.create!(invoice_id: invoice18.id, item_id: @item2.id, quantity: 100, unit_price: @item2.unit_price, status: 'packaged')
      invoice_item20 = InvoiceItem.create!(invoice_id: invoice18.id, item_id: @item3.id, quantity: 100, unit_price: @item3.unit_price, status: 'packaged')
      invoice_item21 = InvoiceItem.create!(invoice_id: invoice18.id, item_id: @item1.id, quantity: 100, unit_price: @item1.unit_price, status: 'packaged')

      transaction23 = invoice18.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction24 = invoice18.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction25 = invoice18.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)


      customer8 = Customer.create!(first_name: 'FName8', last_name: 'LName8')

      invoice19 = customer8.invoices.create!(status: 'completed')

      invoice_item22 = InvoiceItem.create!(invoice_id: invoice19.id, item_id: @item2.id, quantity: 100, unit_price: @item2.unit_price, status: 'packaged')

      transaction26 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction27 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction28 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction29 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction30 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction31 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction29 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction30 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)
      transaction31 = invoice19.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: true)

      customer9 = Customer.create!(first_name: 'FName9', last_name: 'LName9')

      invoice22 = customer9.invoices.create!(status: 'completed')

      invoice_item24 = InvoiceItem.create!(invoice_id: invoice22.id, item_id: @item3.id, quantity: 100, unit_price: @item3.unit_price, status: 'packaged')

      transaction32 = invoice22.transactions.create!(credit_card_number: '1234234534564567', credit_card_expiration_date: nil, result: false)

      visit merchant_path(@merchant1.id)

      within('#favorite_customers') do
        expect(page).to have_content("Favorite Customers")
        expect(page).to have_content("1. #{customer8.first_name} #{customer8.last_name} - #{@merchant1.top_customers.first.total_count}")
        expect(page).to have_content("2. #{customer5.first_name} #{customer5.last_name} - #{@merchant1.top_customers.second.total_count}")
        expect(page).to have_content("3. #{customer6.first_name} #{customer6.last_name} - #{@merchant1.top_customers.third.total_count}")
        expect(page).to have_content("4. #{customer7.first_name} #{customer7.last_name} - #{@merchant1.top_customers.fourth.total_count}")
        expect(page).to have_content("5. #{@customer1.first_name} #{@customer1.last_name} - #{@merchant1.top_customers.last.total_count}")

      end
    end
  end
end
