require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'header on dashboard' do
    it 'displays a header on the admin dashboard' do
      visit '/admin'

      expect(page).to have_content('Admin Dashboard')
    end
  end

  describe 'links to indices' do
    it 'displays link and links to admin merchants index page' do
      visit '/admin'
      expect(page).to have_button('Merchants')
    end

    it 'displays link and links to admin invoices index page' do
      visit '/admin'
      expect(page).to have_button('Invoices')
    end
  end

  describe 'top customers' do
    it 'displays names of top 5 customers with successful transactions' do
      @customer_1  = Customer.create!(first_name: 'Tanya', last_name: 'Tiger')
      @invoice_1 = @customer_1.invoices.create!(status: 1)
      @transaction_1 = @invoice_1.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
      @transaction_2 = @invoice_1.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
      @transaction_3 = @invoice_1.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)

      @customer_2  = Customer.create!(first_name: 'Jerry', last_name: 'Jones')
      @invoice_2 = @customer_2.invoices.create!(status: 1)
      @transaction_4 = @invoice_2.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)

      @customer_3  = Customer.create!(first_name: 'Adam', last_name: 'Asop')
      @invoice_3 = @customer_3.invoices.create!(status: 1)
      @invoice_4 = @customer_3.invoices.create!(status: 1)
      @transaction_5 = @invoice_3.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
      @transaction_6 = @invoice_3.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
      @transaction_7 = @invoice_4.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
      @transaction_8 = @invoice_4.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
      @transaction_9 = @invoice_4.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)

      @customer_4  = Customer.create!(first_name: 'Sammy', last_name: 'Smith')
      @invoice_5 = @customer_4.invoices.create!(status: 1)
      @transaction_10 = @invoice_5.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 1)

      @customer_5  = Customer.create!(first_name: 'Derek', last_name: 'Davis')
      @invoice_6 = @customer_5.invoices.create!(status: 1)
      @transaction_11 = @invoice_6.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
      @transaction_12 = @invoice_6.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
      @transaction_13 = @invoice_6.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)

      @customer_6  = Customer.create!(first_name: 'Robin', last_name: 'Ringer')
      @invoice_7 = @customer_6.invoices.create!(status: 1)
      @transaction_14 = @invoice_7.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
      @transaction_15 = @invoice_7.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)

      @customer_7  = Customer.create!(first_name: 'Yule', last_name: 'Young')
      @invoice_8 = @customer_7.invoices.create!(status: 1)
      @transaction_16 = @invoice_8.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
      @transaction_17 = @invoice_8.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
      @transaction_18 = @invoice_8.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)

      visit('/admin')

      expect(@customer_3.first_name).to appear_before(@customer_1.first_name)
      expect(@customer_3.first_name).to appear_before(@customer_5.first_name)
      expect(@customer_7.first_name).to appear_before(@customer_6.first_name)
      expect(page).to_not have_content(@customer_2.first_name)
      expect(page).to_not have_content(@customer_4.first_name)
    end
  end

  describe 'incomplete invoices' do
    it 'displays a list of ids of all invoices that have not yet been shipped' do
      @customer_1  = Customer.create!(first_name: 'Tanya', last_name: 'Tiger')
      @invoice_1 = @customer_1.invoices.create!(status: 0)
      @invoice_2 = @customer_1.invoices.create!(status: 1)
      @invoice_3 = @customer_1.invoices.create!(status: 1)
      @invoice_4 = @customer_1.invoices.create!(status: 2)
      @invoice_5 = @customer_1.invoices.create!(status: 0)

      @merchant_1 = Merchant.create!(name: 'Roald')
      @item_1 = @merchant_1.items.create!(name: 'Doritos', description: 'Delicious', unit_price: 39434)
      @item_2 = @merchant_1.items.create!(name: 'Lays', description: 'Deliciouio', unit_price: 8356)
      @item_3 = @merchant_1.items.create!(name: 'Cadlee', description: 'Perfecto', unit_price: 9064)

      InvoiceItem.create!(invoice: @invoice_1, item: @item_1, status: 0, quantity: 200, unit_price: 39434)
      InvoiceItem.create!(invoice: @invoice_2, item: @item_2, status: 1, quantity: 295, unit_price: 8356)
      InvoiceItem.create!(invoice: @invoice_3, item: @item_3, status: 1, quantity: 382, unit_price: 9064)
      InvoiceItem.create!(invoice: @invoice_4, item: @item_1, status: 2, quantity: 130, unit_price: 39434)
      InvoiceItem.create!(invoice: @invoice_5, item: @item_1, status: 1, quantity: 97, unit_price: 39434)

      visit('/admin')

      expect(page).to have_content("Invoice-#{@invoice_1.id}")
      expect(page).to have_content("Invoice-#{@invoice_2.id}")
      expect(page).to have_content("Invoice-#{@invoice_3.id}")
      expect(page).to_not have_content("Invoice-#{@invoice_4.id}")
      expect(page).to have_content("Invoice-#{@invoice_5.id}")
    end

    it 'displays a list of ids of all invoices from descending order from created_at date' do
      @customer_1  = Customer.create!(first_name: 'Tanya', last_name: 'Tiger')
      @invoice_1 = @customer_1.invoices.create!(status: 0)
      @invoice_2 = @customer_1.invoices.create!(status: 1)
      @invoice_5 = @customer_1.invoices.create!(status: 0)
      @invoice_3 = @customer_1.invoices.create!(status: 1)
      @invoice_4 = @customer_1.invoices.create!(status: 2)

      @merchant_1 = Merchant.create!(name: 'Roald')
      @item_1 = @merchant_1.items.create!(name: 'Doritos', description: 'Delicious', unit_price: 39434)
      @item_2 = @merchant_1.items.create!(name: 'Lays', description: 'Deliciouio', unit_price: 8356)
      @item_3 = @merchant_1.items.create!(name: 'Cadlee', description: 'Perfecto', unit_price: 9064)

      InvoiceItem.create!(invoice: @invoice_1, item: @item_1, status: 0, quantity: 200, unit_price: 39434)
      InvoiceItem.create!(invoice: @invoice_2, item: @item_2, status: 1, quantity: 295, unit_price: 8356)
      InvoiceItem.create!(invoice: @invoice_5, item: @item_1, status: 1, quantity: 97, unit_price: 39434)
      InvoiceItem.create!(invoice: @invoice_4, item: @item_1, status: 2, quantity: 130, unit_price: 39434)
      InvoiceItem.create!(invoice: @invoice_3, item: @item_3, status: 1, quantity: 382, unit_price: 9064)

      visit('/admin')

      expect("Invoice-#{@invoice_1.id}").to appear_before("Invoice-#{@invoice_5.id}")
      expect("Invoice-#{@invoice_1.id}").to appear_before("Invoice-#{@invoice_2.id}")
      expect("Invoice-#{@invoice_1.id}").to appear_before("Invoice-#{@invoice_3.id}")
      expect("Invoice-#{@invoice_2.id}").to appear_before("Invoice-#{@invoice_5.id}")
      expect("Invoice-#{@invoice_2.id}").to appear_before("Invoice-#{@invoice_3.id}")
      expect("Invoice-#{@invoice_5.id}").to appear_before("Invoice-#{@invoice_3.id}")
    end
  end
end
