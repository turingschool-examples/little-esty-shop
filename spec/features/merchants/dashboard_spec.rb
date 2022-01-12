require 'rails_helper'

describe 'Merchant Dashboard' do
  before do
    @merchant = create :merchant
    @customer = create :customer
    @item1 = create :item, { merchant_id: @merchant.id }
    @item2 = create :item, { merchant_id: @merchant.id }
    @item3 = create :item, { merchant_id: @merchant.id }
    @invoice1 = create :invoice, { customer_id: @customer.id }
    @invoice2 = create :invoice, { customer_id: @customer.id }
    @invoice_item1 = create :invoice_item, { invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 10, status: 0 }
    @invoice_item2 = create :invoice_item, { invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, unit_price: 20, status: 1 }
    @invoice_item3 = create :invoice_item, { invoice_id: @invoice2.id, item_id: @item3.id, quantity: 1, unit_price: 30, status: 2 }

    visit merchant_dashboard_index_path(@merchant)
  end

  describe 'display' do
    it 'displays merchant name' do
      expect(page).to have_content(@merchant.name)
    end

    it 'has a link to view all merchant items' do
      click_link "Merchant Items"
      expect(current_path).to eq(merchant_items_path(@merchant))
    end

    it 'has a link to view all merchant invoices' do
      click_link "Merchant Invoices"
      expect(current_path).to eq(merchant_invoices_path(@merchant))
    end

    describe 'section for items ready to ship' do
      it 'list items, with their invoice id, that have not been shipped, in order' do
        within("#items_ready_to_ship") do
          expect(page).to have_content('Items Ready to Ship:')
          expect(page).to have_content(@item1.name)
          expect(page).to have_content(@item1.invoice_ids[0])
          expect(page).to have_content(@item2.name)
          expect(page).to have_content(@item2.invoice_ids[0])
          expect(page).to_not have_content(@item3.name)
          expect(page).to_not have_content(@item3.invoice_ids[0])
        end
      end

      it 'each invoice id is a link to merchant invoice show' do
        within("#items_ready_to_ship") do
          click_link(@invoice1.id, match: :first)
          expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice1))
        end
      end
    end
  end

  it "lists items ready to ship from oldest to newest" do
    customer_1 = create(:customer)
    merchant_6 = Merchant.create!(name: 'Rob')
    item_6 = create(:item, merchant_id: merchant_6.id, unit_price: 5, name: 'item_6_name')
    item_7 = create(:item, merchant_id: merchant_6.id, unit_price: 5, name: 'item_7_name')
    item_8 = create(:item, merchant_id: merchant_6.id, unit_price: 5, name: 'item_8_name')
    item_9 = create(:item, merchant_id: merchant_6.id, unit_price: 5, name: 'item_9_name')
    invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-25 09:54:09 UTC")
    invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2013-03-25 09:54:09 UTC")
    invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2014-03-25 09:54:09 UTC")
    invoice_9 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2015-03-25 09:54:09 UTC")
    invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_6.id, status: 1, quantity: 1, unit_price: 5)
    invoice_item_7 = create(:invoice_item, item_id: item_7.id, invoice_id: invoice_7.id, status: 1, quantity: 10, unit_price: 5)
    invoice_item_8 = create(:invoice_item, item_id: item_8.id, invoice_id: invoice_8.id, status: 1, quantity: 10, unit_price: 5)
    invoice_item_9 = create(:invoice_item, item_id: item_9.id, invoice_id: invoice_9.id, status: 2, quantity: 10, unit_price: 5)

    # visit "/merchants/#{merchant_6.id}/dashboard"
    visit merchant_dashboard_index_path(merchant_6)

    within '#ready_to_ship' do
      expect(page).to have_content("Item: #{item_6.name} - Invoice Date: #{invoice_6.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Item: #{item_7.name} - Invoice Date: #{invoice_7.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Item: #{item_8.name} - Invoice Date: #{invoice_8.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to_not have_content("Item: #{item_9.name} - Invoice Date: #{invoice_9.created_at.strftime("%A, %B %d, %Y")}")

      expect(item_6.name).to appear_before(item_7.name)
      expect(item_7.name).to appear_before(item_8.name)
    end
  end
  it "lists top 5 customers and number of successful transactions for each customer" do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    item_1 = create(:item, merchant_id: merchant_1.id, unit_price: 5, name: 'item_1_name')

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

    visit merchant_dashboard_index_path(merchant_1)

    within("#top_five_customers") do
      expect(page).to have_content("Customer: #{customer_1.full_name} - Total Transactions: 6")
      expect(page).to have_content("Customer: #{customer_2.full_name} - Total Transactions: 5")
      expect(page).to have_content("Customer: #{customer_4.full_name} - Total Transactions: 4")
      expect(page).to have_content("Customer: #{customer_3.full_name} - Total Transactions: 3")
      expect(page).to have_content("Customer: #{customer_5.full_name} - Total Transactions: 2")
      expect(page).to_not have_content("Customer: #{customer_6.full_name} - Total Transactions: 1")

      expect(customer_1.full_name).to appear_before(customer_2.full_name)
      expect(customer_2.full_name).to appear_before(customer_4.full_name)
      expect(customer_4.full_name).to appear_before(customer_3.full_name)
      expect(customer_3.full_name).to appear_before(customer_5.full_name)
    end
  end
end
