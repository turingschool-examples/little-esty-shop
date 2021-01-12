require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'As an admin user' do
    before(:each) do
      # Customers:
      @sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
      @joel     = Customer.create!(first_name: 'Joel', last_name: 'Hansen')
      @billy    = Customer.create!(first_name: 'Billy', last_name: 'Joel')
      @steve    = Customer.create!(first_name: 'Steve', last_name: 'Carrell')
      @frank    = Customer.create!(first_name: 'Frank', last_name: 'Sinatra')
      @Jon      = Customer.create!(first_name: 'Jon', last_name: 'Travolta')
      # Merchants:
      @amazon   = Merchant.create!(name: 'Amazon')
      @alibaba  = Merchant.create!(name: 'Alibaba')
      # Invoices:
      @invoice1 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: @amazon.id, created_at: 'Fri, 08 Dec 2020 14:42:18 UTC +00:00')
      @invoice2 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: @alibaba.id)
      @invoice3 = Invoice.create!(status: 0, customer_id: @billy.id, merchant_id: @alibaba.id)
      @invoice4 = Invoice.create!(status: 0, customer_id: @steve.id, merchant_id: @amazon.id)
      @invoice5 = Invoice.create!(status: 0, customer_id: @frank.id, merchant_id: @alibaba.id)
      @invoice6 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: @alibaba.id)
      @invoice7 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: @alibaba.id)
      # Transactions:
      @tx1      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: @invoice2.id,)
      @tx2      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'failed', invoice_id: @invoice1.id,)
      @tx3      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: @invoice3.id,)
      @tx4      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: @invoice4.id,)
      @tx5      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: @invoice5.id,)
      @tx6      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: @invoice5.id,)
      @tx7      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'failed', invoice_id: @invoice6.id,)
      @tx8      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: @invoice7.id,)
      # Items:
      @candle   = Item.create!(name: 'Lavender Candle', description: '8oz Soy Candle', unit_price: 7.0, merchant_id: @amazon.id)
      @backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: @alibaba.id)
      @radio    = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: @amazon.id)
      # InvoiceItems:
      @invitm1  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: @invoice1.id, item_id: @candle.id)
      @invitm2  = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 15.5, invoice_id: @invoice2.id, item_id: @backpack.id)
      @invitm3  = InvoiceItem.create!(status: 1, quantity: 100, unit_price: 9.75, invoice_id: @invoice3.id, item_id: @backpack.id)
    end

    describe 'Admin Dashboard' do
      it "I see a header indicating that I am on the admin dashboard" do
        visit admin_root_path

        expect(page).to have_content("Admin Dashboard")
      end
    end

    describe 'Admin Dashboard Links' do
      it 'I see a link to the admin merchants and invoices index' do
        visit admin_root_path

        expect(page).to have_link('Merchants')
        expect(page).to have_link('Invoices')

        click_link 'Merchants'

        expect(current_path).to eq(admin_merchants_path)

        visit admin_root_path

        click_link 'Invoices'

        expect(current_path).to eq(admin_invoices_path)
      end
    end

    describe 'Admin Dashboard Incomplete Invoices' do
      it 'I see a list of all the ids of the invoices whose items have not been shipped and the invoices link to their admin page' do
        visit admin_root_path
  
        expect(page).to have_content('Incomplete Invoices')
        expect(page).to have_content(@invoice1.id)
        expect(page).to_not have_content(@invoice2.id)
        expect(page).to have_link(@invoice1.id.to_s)
  
        click_link(@invoice1.id.to_s)
  
        expect(current_path).to eq(admin_invoice_path(@invoice1.id))
      end
    end

    describe 'Admin Dashboard Invoices sorted by least recent' do
      it 'Next to each invoice id I see the date it was created and the list is ordered from oldest to newest' do
        visit admin_root_path
  
        date_inv1 = "#{@invoice1.created_at.strftime("Created: %A, %B %d, %Y")}"
        date_inv3 = "#{@invoice3.created_at.strftime("Created: %A, %B %d, %Y")}"
  
        expect(page).to have_link(@invoice1.id.to_s)
        expect(page).to have_content(date_inv1)
        expect(page).to have_link(@invoice3.id.to_s)
        expect(page).to have_content(date_inv3)
        expect(date_inv1).to appear_before(date_inv3)
        expect(date_inv3).to_not appear_before(date_inv1)
      end
    end
 
    describe 'Admin Dashboard Statistics - Top Customers' do
      it 'I see the names of the top 5 customers and their number of sucessful transactions' do
        visit admin_root_path
  
        expect(page).to have_content('Top 5 Customers')
        expect(page).to have_content("#{@frank.first_name} #{@frank.last_name}: 2")
        expect(page).to have_content("#{@sally.first_name} #{@sally.last_name}: 1")
        expect(page).to have_content("#{@joel.first_name} #{@joel.last_name}: 1")
        expect(page).to have_content("#{@billy.first_name} #{@billy.last_name}: 1")
        expect(page).to have_content("#{@steve.first_name} #{@steve.last_name}: 1")
      end
    end
  end 
end 




