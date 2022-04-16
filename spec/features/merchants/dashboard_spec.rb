require 'rails_helper'

RSpec.describe 'Merchant Dashboard Page' do

  before do

    @merch1 = Merchant.create!(name: 'Jeffs Gold Blooms', created_at: Time.now, updated_at: Time.now)
    @merch2 = Merchant.create!(name: 'Miyazakis Dark Souls', created_at: Time.now, updated_at: Time.now)
    visit "/merchants/#{@merch1.id}/dashboard"
    # save_and_open_page
  end

  describe 'As a Merchant' do

    it 'I visit my merchant dashboard, and see the name of my merchant' do
      expect(page).to have_content("Jeffs Gold Blooms")
      expect(page).to_not have_content('Miyazakis Dark Souls')
    end

    it 'I see a link to my merchant items index' do
      expect(page).to have_link("My Items")
    end

    it 'I see a link to my merchant invoice index' do
      expect(page).to have_link("My Invoices")
    end

    it 'lists top 5 customers and number of successful transactions for each customer' do
      merchant_1 = Merchant.create!(name: 'merchant_1', created_at: Time.now, updated_at: Time.now)
      item_1 = create(:item, merchant_id: merchant_1.id, unit_price: 750, name: 'item_1_name')

      customer_1 = create(:customer)
      invoice_1 = create(:invoice, customer_id: customer_1.id)
      transaction_list_1 = FactoryBot.create_list(:transaction, 6, invoice_id: invoice_1.id, result: 0)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, status: 2, quantity: 1, unit_price: 1)

      customer_2 = create(:customer)
      invoice_2 = create(:invoice, customer_id: customer_2.id)
      transaction_list_2 = FactoryBot.create_list(:transaction, 5, invoice_id: invoice_2.id, result: 0)
      invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_2.id, status: 2, quantity: 1, unit_price: 1)

      customer_3 = create(:customer)
      invoice_3 = create(:invoice, customer_id: customer_3.id)
      transaction_list_3 = FactoryBot.create_list(:transaction, 3, invoice_id: invoice_3.id, result: 0)
      invoice_item_3 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_3.id, status: 2, quantity: 1, unit_price: 1)

      customer_4 = create(:customer)
      invoice_4 = create(:invoice, customer_id: customer_4.id)
      transaction_list_4 = FactoryBot.create_list(:transaction, 4, invoice_id: invoice_4.id, result: 0)
      invoice_item_4 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_4.id, status: 2, quantity: 1, unit_price: 1)

      customer_5 = create(:customer)
      invoice_5 = create(:invoice, customer_id: customer_5.id)
      transaction_list_5 = FactoryBot.create_list(:transaction, 2, invoice_id: invoice_5.id, result: 0)
      invoice_item_5 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_5.id, status: 2, quantity: 1, unit_price: 1)

      customer_6 = create(:customer)
      invoice_6 = create(:invoice, customer_id: customer_6.id)
      transaction_list_6 = FactoryBot.create_list(:transaction, 1, invoice_id: invoice_6.id, result: 0)
      invoice_item_6 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_6.id, status: 2, quantity: 1, unit_price: 1)

      visit "/merchants/#{merchant_1.id}/dashboard"

      within("#top_five_customers") do
        expect(page).to have_content("Customer: #{customer_1.full_name} - Total Transactions: 6")
        expect(page).to have_content("Customer: #{customer_2.full_name} - Total Transactions: 5")
        expect(page).to have_content("Customer: #{customer_3.full_name} - Total Transactions: 3")
        expect(page).to have_content("Customer: #{customer_4.full_name} - Total Transactions: 4")
        expect(page).to have_content("Customer: #{customer_5.full_name} - Total Transactions: 2")
        expect(page).to_not have_content("Customer: #{customer_6.full_name} - Total Transactions: 1")
      end
    end

    it "displays items that are ready to ship" do
      merchant_1 = create(:merchant)
      
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_1.id)
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id, status: 1)
      invoice_item_1 = create(:invoice_item, status: 0, item_id: item_1.id, invoice_id: invoice.id)
      invoice_item_2 = create(:invoice_item, status: 2, item_id: item_2.id, invoice_id: invoice.id)
      visit "/merchants/#{merchant_1.id}/dashboard"
      expect(page).to have_content("Items Ready to Ship")
      
      within "#items_ready_to_ship" do
        expect(page).to have_content(item_1.name)
        expect(page).to_not have_content(item_2.name)
      end
      
      within "#invoice-item-#{invoice_item_1.id}" do
        expect(page).to have_content(item_1.name)
        expect(page).to have_link("#{invoice.id}")
      end
      
      click_link "#{invoice.id}"
      expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices/#{invoice.id}")
    end
    
    it "displays created_at date for each invoice in 'Ready to Ship' and they are ordered oldest to newest" do
      merchant_1 = create(:merchant)
      
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_1.id)
      item_3 = create(:item, merchant_id: merchant_1.id)
      customer = create(:customer)
      date_1 = 	"2015-02-08 09:54:09 UTC".to_datetime
      date_2 = 	"2020-02-21 09:54:09 UTC".to_datetime
      date_3 = 	"2018-03-12 09:54:09 UTC".to_datetime
      invoice_1 = create(:invoice, customer_id: customer.id, status: 1, created_at: date_1)
      invoice_2 = create(:invoice, customer_id: customer.id, status: 1, created_at: date_2)
      invoice_3 = create(:invoice, customer_id: customer.id, status: 1, created_at: date_3)
      invoice_item_1 = create(:invoice_item, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = create(:invoice_item, status: 0, item_id: item_2.id, invoice_id: invoice_2.id)
      invoice_item_3 = create(:invoice_item, status: 0, item_id: item_3.id, invoice_id: invoice_3.id)
      
      visit "/merchants/#{merchant_1.id}/dashboard"
      
      within "#invoice-item-#{invoice_item_1.id}" do
        expect(page).to have_content("February 8, 2015")
      end
      within "#invoice-item-#{invoice_item_2.id}" do
        expect(page).to have_content("February 21, 2020")
      end
      within "#invoice-item-#{invoice_item_3.id}" do
        expect(page).to have_content("March 12, 2018")
      end
      # save_and_open_page
      expect(item_1.name).to appear_before(item_3.name)
      expect(item_3.name).to appear_before(item_2.name)
    end
    #     As a merchant
    # When I visit my merchant dashboard
# In the section for "Items Ready to Ship",
# Next to each Item name I see the date that the invoice was created
# And I see the date formatted like "Monday, July 18, 2019"
# And I see that the list is ordered from oldest to newest
  end

end
