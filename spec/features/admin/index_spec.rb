require 'rails_helper'

RSpec.describe 'Admin#index' do
  it 'Displays a header that user is on Admin' do
    visit '/admin'
    expect(page).to have_content('Admin')
  end
  # Admin Dashboard Links
  # As an admin,
  # When I visit the admin dashboard (/admin)
  # Then I see a link to the admin merchants index (/admin/merchants)
  # And I see a link to the admin invoices index (/admin/invoices)
  it 'It has links to Admin/merchants' do
    visit '/admin'
    expect(page).to have_link('Merchants')
  end

  it 'It has links to Admin invoices' do
    visit '/admin'
    expect(page).to have_link('Invoices')
  end

  # Admin Dashboard Statistics - Top Customers
  # As an admin,
  # When I visit the admin dashboard
  # Then I see the names of the top 5 customers
  # who have conducted the largest number of successful transactions
  # And next to each customer name I see the number of successful transactions they have conducted
  describe 'On admin dashboard we see top 5 customers' do
    before :each do
      @customer_1 = Customer.create!(first_name: 'Eli', last_name: 'Fuchsman')
      @customer_2 = Customer.create!(first_name: 'Bryan', last_name: 'Keener')
      @customer_3 = Customer.create!(first_name: 'Darby', last_name: 'Smith')
      @customer_4 = Customer.create!(first_name: 'James', last_name: 'White')
      @customer_5 = Customer.create!(first_name: 'William', last_name: 'Lampke')
      @customer_6 = Customer.create!(first_name: 'Abdul', last_name: 'Redd')

      @merchant = Merchant.create!(name: 'Test')

      @item_1 = Item.create!(name: 'item1', description: 'desc1', unit_price: 10, merchant_id: @merchant.id)

      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1)
      @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 1)
      @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: 1)
      @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: 1)
      @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: 1)
      @invoice_6 = Invoice.create!(customer_id: @customer_2.id, status: 1)
      @invoice_7 = Invoice.create!(customer_id: @customer_2.id, status: 1)
      @invoice_8 = Invoice.create!(customer_id: @customer_4.id, status: 1)

      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 1)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 1)
      @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_1.id, quantity: 2, unit_price: 10, status: 1)
      @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_1.id, quantity: 3, unit_price: 10, status: 1)
      @ii_5 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 1)

      @transaction_1 = Transaction.create!(credit_card_number: '1', result: 0, invoice_id: @invoice_1.id)
      @transaction_2 = Transaction.create!(credit_card_number: '2', result: 0, invoice_id: @invoice_2.id)
      @transaction_3 = Transaction.create!(credit_card_number: '3', result: 0, invoice_id: @invoice_3.id)
      @transaction_4 = Transaction.create!(credit_card_number: '4', result: 0, invoice_id: @invoice_4.id)
      @transaction_5 = Transaction.create!(credit_card_number: '5', result: 0, invoice_id: @invoice_5.id)
      @transaction_6 = Transaction.create!(credit_card_number: '5', result: 0, invoice_id: @invoice_6.id)
      @transaction_7 = Transaction.create!(credit_card_number: '5', result: 0, invoice_id: @invoice_7.id)
      @transaction_8 = Transaction.create!(credit_card_number: '5', result: 0, invoice_id: @invoice_8.id)
      # binding.pry
    end
    it 'displays top 5 customers' do
      visit '/admin'
      # save_and_open_page
      expect(page).to have_content('Eli Fuchsman: 1')
      expect(page).to have_content('Darby Smith: 1')
      expect(page).to have_content('William Lampke: 1')
      expect(page).to have_content('Bryan Keener: 3')
      expect(page).to have_content('James White: 2')

      expect('Bryan Keener: 3').to appear_before('James White: 2')
      expect('James White: 2').to appear_before('Eli Fuchsman: 1')
      expect('Eli Fuchsman: 1').to appear_before('Darby Smith: 1')
      expect('Darby Smith: 1').to appear_before('William Lampke: 1')
    end
  end
end
