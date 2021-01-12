require 'rails_helper'

RSpec.describe "As a admin user" do
  describe 'When I visit an admin merchant show page' do
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
      @tx1      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 0, invoice_id: @invoice2.id,)
      @tx2      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 1, invoice_id: @invoice1.id,)
      @tx3      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 0, invoice_id: @invoice3.id,)
      @tx4      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 0, invoice_id: @invoice4.id,)
      @tx5      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 0, invoice_id: @invoice5.id,)
      @tx6      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 0, invoice_id: @invoice5.id,)
      @tx7      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 1, invoice_id: @invoice6.id,)
      @tx8      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 0, invoice_id: @invoice7.id,)
      # Items:
      @candle   = Item.create!(name: 'Lavender Candle', description: '8oz Soy Candle', unit_price: 7.0, merchant_id: @amazon.id)
      @backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: @alibaba.id)
      @radio    = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: @amazon.id)
      # InvoiceItems:
      @invitm1  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: @invoice1.id, item_id: @candle.id)
      @invitm2  = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 15.5, invoice_id: @invoice2.id, item_id: @backpack.id)
      @invitm3  = InvoiceItem.create!(status: 1, quantity: 100, unit_price: 9.75, invoice_id: @invoice3.id, item_id: @radio.id)
    end
    it "I can see the name of each merchants in the system" do
      visit admin_merchants_path

      within "#merchant-#{@amazon.id}" do
        expect(page).to have_content(@amazon.name)
      end

      within "#merchant-#{@alibaba.id}" do
        expect(page).to have_content(@alibaba.name)
      end
    end

    it "Next to each merchant name I see a button to disable or enable that merchant" do
      visit admin_merchants_path

      within "#merchant-#{@alibaba.id}" do
        expect(page).to have_content('Status: Disabled')
        expect(page).to have_button('Enable')
        click_button('Enable')
      end

      expect(current_path).to eq(admin_merchants_path)

      within "#merchant-#{@amazon.id}" do
        expect(page).to have_content('Status: Enabled')
        expect(page).to have_button('Disable')
        click_button('Disable')
      end
    end

    it "I see Admin Merchants Grouped by Status" do
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

    it "I see and click a link to create a new merchant" do
      visit admin_merchants_path
      
      expect(page).to have_link("New Merchant")

      click_link('New Merchant')
      expect(current_path).to eq(new_admin_merchant_path)
      
      fill_in 'Name:', with: 'All Birds'
      click_on 'Submit'

      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content('All Birds')
    end

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
      invoice7 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: all_birds.id)
      # Transactions:
      tx1      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice2.id,)
      tx2      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'failed', invoice_id: invoice1.id,)
      tx3      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice3.id,)
      tx4      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice4.id,)
      tx5      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice5.id,)
      tx6      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice5.id,)
      tx7      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice6.id,)
      tx8      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice7.id,)
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
      expect(page).to have_content('Top 5 Merchants by Revenue')
      
      expect(page).to have_content("All Birds - $1950.0 in sales")
      expect(page).to have_content("Big Lots - $1267.5 in sales")
      expect(page).to have_content("Walmart - $487.5 in sales")
      expect(page).to have_content("Overstock - $292.5 in sales")
      expect(page).to have_content("Alibaba - $155.0 in sales")
      within(".merchant-top5") do
        expect(page).to have_link(all_birds.name)
        expect(page).to have_link(alibaba.name)
        expect(page).to have_link(walmart.name)
        expect(page).to have_link(big_lots.name)
        expect(page).to have_link(overstock.name)
        click_link(overstock.name)
      end

      expect(current_path).to eq(admin_merchant_path(overstock.id))
    end

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
      invoice7 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: all_birds.id)
      # Transactions:
      tx1      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice2.id,)
      tx2      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'failed', invoice_id: invoice1.id,)
      tx3      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice3.id,)
      tx4      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 'success', invoice_id: invoice4.id,)
      tx5      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice5.id,)
      tx6      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice5.id,)
      tx7      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice6.id,)
      tx8      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 'success', invoice_id: invoice7.id,)
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
        expect(page).to have_content("Top selling date for #{all_birds.name} was #{invoice3.created_at.strftime('%m/%d/%y')}")
        expect(page).to have_content("Top selling date for #{alibaba.name} was #{invoice2.created_at.strftime('%m/%d/%y')}")
        expect(page).to have_content("Top selling date for #{walmart.name} was #{invoice4.created_at.strftime('%m/%d/%y')}")
        expect(page).to have_content("Top selling date for #{big_lots.name} was #{invoice5.created_at.strftime('%m/%d/%y')}")
        expect(page).to have_content("Top selling date for #{overstock.name} was #{invoice6.created_at.strftime('%m/%d/%y')}")
      end
    end
  end
end
