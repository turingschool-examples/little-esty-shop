
# require 'rails_helper'
#
# RSpec.describe 'As a Merchant', type: :feature do
#   describe 'When i visit merchant dashboard' do
#     it 'list the name of my merchant' do
#       @merchant = Merchant.create!(name: "Lizzy")
#
#       visit merchant_dashboard_index_path(@merchant)
#       expect(page).to have_content(@merchant.name)
#     end
#   end
# end

require 'rails_helper'

RSpec.describe 'As a Merchant', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Amazon')

    @item_1 = @merchant_1.items.create!(name: 'worker pain', unit_price: 1)
    @item_2 = @merchant_1.items.create!(name: 'union busting', unit_price: 3)
    @item_3 = @merchant_1.items.create!(name: 'climate desctruction', unit_price: 2)

    @customer_1 = Customer.create!(first_name: "Bob", last_name: "Gu")
    @customer_2 = Customer.create!(first_name: "Steve", last_name: "Smith")
    @customer_3 = Customer.create!(first_name: "Jill", last_name: "Biden")
    @customer_4 = Customer.create!(first_name: "Adriana", last_name: "Green")
    @customer_5 = Customer.create!(first_name: "Sally", last_name: "May")
    @customer_6 = Customer.create!(first_name: "Jo", last_name: "Shmoe")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: "completed")
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: "completed")
    @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: "completed")
    @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: "completed")
    @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: "completed")
    @invoice_6 = Invoice.create!(customer_id: @customer_6.id, status: "completed")

    @invoice_items_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1)
    @invoice_items_2 = InvoiceItem.create!(item: @item_1, invoice: @invoice_2)
    @invoice_items_3 = InvoiceItem.create!(item: @item_1, invoice: @invoice_3)
    @invoice_items_4 = InvoiceItem.create!(item: @item_1, invoice: @invoice_4)
    @invoice_items_5 = InvoiceItem.create!(item: @item_1, invoice: @invoice_5)
    @invoice_items_6 = InvoiceItem.create!(item: @item_1, invoice: @invoice_6)

    @transaction_01 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000000000, cc_expiration_date: '2000-01-01 00:00:00 -0500', result: true)
    @transaction_02 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000001111, cc_expiration_date: '2001-01-01 00:00:00 -0500', result: true)
    @transaction_03 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000002222, cc_expiration_date: '2002-01-01 00:00:00 -0500', result: true)
    @transaction_04 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_05 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
    @transaction_06 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
    @transaction_07 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000004444, cc_expiration_date: '2005-01-01 00:00:00 -0500', result: true)
    @transaction_08 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_09 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_10 = Transaction.create!(invoice_id: @invoice_3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_11 = Transaction.create!(invoice_id: @invoice_3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_12 = Transaction.create!(invoice_id: @invoice_4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_13 = Transaction.create!(invoice_id: @invoice_5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_14 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_15 = Transaction.create!(invoice_id: @invoice_5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_16 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_17 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_18 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_19 = Transaction.create!(invoice_id: @invoice_3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_20 = Transaction.create!(invoice_id: @invoice_4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_21 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_22 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
  end

  describe 'When i visit merchant dashboard' do
    it 'list the name of my merchant' do

      visit merchant_dashboard_index_path(@merchant_1)
      expect(page).to have_content(@merchant_1.name)
    end

    it "has links to the merchant's invoice index and item index" do
      visit merchant_dashboard_index_path(@merchant_1)

      expect(page).to have_content('Merchant Items Index')
      expect(page).to have_link(href: merchant_items_path(@merchant_1))

      expect(page).to have_content('Merchant Invoices Index')
      expect(page).to have_link(href: merchant_invoices_path(@merchant_1))
    end

    it "lists my top five customers and the number of their succesful transactions" do
      visit merchant_dashboard_index_path(@merchant_1)

      within "#customer-#{@customer_1.first_name}" do
        expect(page).to have_content(@customer_1.first_name)
        expect(page).to have_content(@customer_1.last_name)
        expect(page).to have_content(@customer_1.transactions.count)
      end

      within "#customer-#{@customer_2.first_name}" do
        expect(page).to have_content(@customer_2.first_name)
        expect(page).to have_content(@customer_2.last_name)
        expect(page).to have_content(@customer_2.transactions.count)
      end

      within "#customer-#{@customer_3.first_name}" do
        expect(page).to have_content(@customer_3.first_name)
        expect(page).to have_content(@customer_3.last_name)
        expect(page).to have_content(@customer_3.transactions.count)
      end

      within "#customer-#{@customer_4.first_name}" do
        expect(page).to have_content(@customer_4.first_name)
        expect(page).to have_content(@customer_4.last_name)
        expect(page).to have_content(@customer_4.transactions.count)
      end

      within "#customer-#{@customer_6.first_name}" do
        expect(page).to have_content(@customer_6.first_name)
        expect(page).to have_content(@customer_6.last_name)
        expect(page).to have_content(@customer_6.transactions.count)
      end
    end
  end
end
