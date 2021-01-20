require 'rails_helper'

RSpec.describe "As a admin user" do
  describe 'When I visit an admin merchant index page' do
    before(:each) do
      # Customers:
      @sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
      @joel     = Customer.create!(first_name: 'Joel', last_name: 'Hansen')
      @billy    = Customer.create!(first_name: 'Billy', last_name: 'Joel')
      @steve    = Customer.create!(first_name: 'Steve', last_name: 'Carrell')
      @frank    = Customer.create!(first_name: 'Frank', last_name: 'Sinatra')
      @Jon      = Customer.create!(first_name: 'Jon', last_name: 'Travolta')
      # Merchants:
      @amazon   = Merchant.create!(name: 'Amazon', status: 0)
      @alibaba  = Merchant.create!(name: 'Alibaba', status: 1)
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
      @invitm3  = InvoiceItem.create!(status: 1, quantity: 100, unit_price: 9.75, invoice_id: @invoice3.id, item_id: @radio.id)
    end

    describe 'Admin Merchants Index' do
      it "I can see the name of each merchants in the system" do
        visit admin_merchants_path

        within ".merchant-enabled" do
          expect(page).to have_content(@amazon.name)
        end

        within ".merchant-disabled" do
          expect(page).to have_content(@alibaba.name)
        end
      end
    end

    describe 'Admin Merchant Enable/Disable' do
      it "Next to each merchant name I see a button to disable or enable that merchant" do
        visit admin_merchants_path

        within "#merchant-disabled-#{@alibaba.id}" do
          expect(page).to have_content(@alibaba.name)
          expect(page).to have_button('Enable')
          click_button('Enable')
          expect(current_path).to eq(admin_merchants_path)
        end

        within "#merchant-enabled-#{@amazon.id}" do
          expect(page).to have_content(@amazon.name)
          expect(page).to have_button('Disable')
          click_button('Disable')
          expect(current_path).to eq(admin_merchants_path)
        end
      end
    end

    describe 'Admin Merchants Grouped by Status' do
      it "I see merchants Grouped by Status" do
        visit admin_merchants_path

        expect(page).to have_content("Enabled Merchants:")
        expect(page).to have_content("Disabled Merchants:")

        within ".merchant-enabled" do
          expect(page).to have_content(@amazon.name)
        end

        within ".merchant-disabled" do
          expect(page).to have_content(@alibaba.name)
        end
      end
    end

    describe 'Admin Merchants: Top 5 Merchants by Revenue' do
      it "I see the names of the top 5 merchants by total revenue generated that are links to their show page" do

        all_birds = Merchant.create!(name: 'All Birds', status: 0)
        walmart   = Merchant.create!(name: 'Walmart', status: 0)
        overstock = Merchant.create!(name: 'Overstock', status: 0)
        big_lots  = Merchant.create!(name: 'Big Lots', status: 0)
        amazon    = Merchant.create!(name: 'Amazon', status: 0)
        alibaba   = Merchant.create!(name: 'Alibaba', status: 1)
        # Invoices:
        invoice1 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: amazon.id)
        invoice2 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: alibaba.id)
        invoice3 = Invoice.create!(status: 0, customer_id: @billy.id, merchant_id: all_birds.id)
        invoice4 = Invoice.create!(status: 0, customer_id: @steve.id, merchant_id: overstock.id)
        invoice5 = Invoice.create!(status: 0, customer_id: @frank.id, merchant_id: big_lots.id)
        invoice6 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: walmart.id)
        # Transactions:
        tx1      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice2.id,)
        tx2      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'failed', invoice_id: invoice1.id,)
        tx3      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice3.id,)
        tx4      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice4.id,)
        tx5      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice5.id,)
        tx6      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice5.id,)
        tx7      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice6.id,)
        # Items:
        candle   = Item.create!(name: 'Lavender Candle', description: '8oz Soy Candle', unit_price: 7.0, merchant_id: amazon.id)
        backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: alibaba.id)
        radio1   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: all_birds.id)
        radio2   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: walmart.id)
        radio3   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: big_lots.id)
        radio4   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: overstock.id)
        # InvoiceItems:
        invitm1  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: invoice1.id, item_id: candle.id)
        invitm2  = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 15.5, invoice_id: invoice2.id, item_id: backpack.id)
        invitm3  = InvoiceItem.create!(status: 1, quantity: 100, unit_price: 9.75, invoice_id: invoice3.id, item_id: radio1.id)
        invitm4  = InvoiceItem.create!(status: 1, quantity: 50, unit_price: 9.75, invoice_id: invoice4.id, item_id: radio2.id)
        invitm5  = InvoiceItem.create!(status: 1, quantity: 65, unit_price: 9.75, invoice_id: invoice5.id, item_id: radio3.id)
        invitm6  = InvoiceItem.create!(status: 1, quantity: 30, unit_price: 9.75, invoice_id: invoice6.id, item_id: radio4.id)

        visit admin_merchants_path

        expect(page).to have_content('Top Merchants:')

        within(".merchant-top5") do
          expect(page).to have_content("Big Lots - $1267.5 in sales")
          expect(page).to have_content("Amazon - $1150.0 in sales")
          expect(page).to have_content("All Birds - $975.0 in sales")
          expect(page).to have_content("Alibaba - $775.0 in sales")
          expect(page).to have_content("Walmart - $487.5 in sales")
        end

        within(".merchant-top5") do
          expect(page).to have_link(all_birds.name)
          expect(page).to have_link(alibaba.name)
          expect(page).to have_link(walmart.name)
          expect(page).to have_link(big_lots.name)
          expect(page).to have_link(amazon.name)
          click_link(big_lots.name)
          expect(current_path).to eq(admin_merchant_path(big_lots.id))
        end

      end
    end

    describe 'Admin Merchants: Top Merchants Best Day' do
      it "Next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant" do

        all_birds = Merchant.create!(name: 'All Birds', status: 0)
        walmart   = Merchant.create!(name: 'Walmart', status: 0)
        overstock = Merchant.create!(name: 'Overstock', status: 0)
        big_lots  = Merchant.create!(name: 'Big Lots', status: 0)
        amazon    = Merchant.create!(name: 'Amazon', status: 0)
        alibaba   = Merchant.create!(name: 'Alibaba', status: 1)
        # Invoices:
        invoice1 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: amazon.id)
        invoice2 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: alibaba.id)
        invoice3 = Invoice.create!(status: 0, customer_id: @billy.id, merchant_id: all_birds.id)
        invoice4 = Invoice.create!(status: 0, customer_id: @steve.id, merchant_id: overstock.id)
        invoice5 = Invoice.create!(status: 0, customer_id: @frank.id, merchant_id: big_lots.id)
        invoice6 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: walmart.id)
        # Transactions:
        tx1      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice2.id,)
        tx2      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'failed', invoice_id: invoice1.id,)
        tx3      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice3.id,)
        tx4      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice4.id,)
        tx5      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice5.id,)
        tx6      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice5.id,)
        tx7      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice6.id,)
        # Items:
        candle   = Item.create!(name: 'Lavender Candle', description: '8oz Soy Candle', unit_price: 7.0, merchant_id: amazon.id)
        backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: alibaba.id)
        radio1   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: all_birds.id)
        radio2   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: walmart.id)
        radio3   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: big_lots.id)
        radio4   = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: overstock.id)
        # InvoiceItems:
        invitm1  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: invoice1.id, item_id: candle.id)
        invitm2  = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 15.5, invoice_id: invoice2.id, item_id: backpack.id)
        invitm3  = InvoiceItem.create!(status: 1, quantity: 100, unit_price: 9.75, invoice_id: invoice3.id, item_id: radio1.id)
        invitm4  = InvoiceItem.create!(status: 1, quantity: 50, unit_price: 9.75, invoice_id: invoice4.id, item_id: radio2.id)
        invitm5  = InvoiceItem.create!(status: 1, quantity: 65, unit_price: 9.75, invoice_id: invoice5.id, item_id: radio3.id)
        invitm6  = InvoiceItem.create!(status: 1, quantity: 30, unit_price: 9.75, invoice_id: invoice6.id, item_id: radio4.id)

        visit admin_merchants_path

        within(".merchant-top5") do
          expect(page).to have_content("Top selling date for Big Lots was 01/20/21")
          expect(page).to have_content("Top selling date for Amazon was 12/08/20")
          expect(page).to have_content("Top selling date for All Birds was 01/20/21")
          expect(page).to have_content("Top selling date for Alibaba was 01/20/21")
          expect(page).to have_content("Top selling date for Walmart was 01/20/21")
        end
      end
    end
  end
end
