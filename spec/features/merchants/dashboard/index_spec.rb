require 'rails_helper'

RSpec.describe 'Merchant Dashboard Index' do
  before :each do
    @merchant = create(:merchant)
    visit merchant_dashboard_index_path(@merchant.id)
  end

  it 'lists the merchant name' do
    expect(page).to have_content(@merchant.name)
  end

  it 'has a link to merchant items index' do
    expect(page).to have_link("My Items")

    click_link("My Items")

    expect(current_path).to eq(merchant_items_path(@merchant.id))
  end

  it 'has a link to merchant invoices index' do
    expect(page).to have_link("My Invoices")

    click_link("My Invoices")
    
    expect(current_path).to eq(merchant_invoices_path(@merchant.id))
  end

  it 'lists the merchants top 5 customers' do
    item = create(:item, merchant: @merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    customer_3 = create(:customer)
    customer_4 = create(:customer)
    customer_5 = create(:customer)

    invoice_1 = create(:invoice, customer: customer_1)
    invoice_2 = create(:invoice, customer: customer_2)
    invoice_3 = create(:invoice, customer: customer_3)
    invoice_4 = create(:invoice, customer: customer_4)
    invoice_5 = create(:invoice, customer: customer_5)

    invoice_1.items << item
    invoice_2.items << item
    invoice_3.items << item
    invoice_4.items << item
    invoice_5.items << item

    transaction_1 = create(:transaction, invoice: invoice_1, result: :success)
    transaction_2 = create(:transaction, invoice: invoice_2, result: :success)
    transaction_3 = create(:transaction, invoice: invoice_3, result: :success)
    transaction_4 = create(:transaction, invoice: invoice_4, result: :success)
    transaction_5 = create(:transaction, invoice: invoice_5, result: :success)

    visit merchant_dashboard_index_path(@merchant.id)

    top_five_1 = @merchant.top_five_customers[0]
    top_five_2 = @merchant.top_five_customers[1]
    top_five_3 = @merchant.top_five_customers[2]
    top_five_4 = @merchant.top_five_customers[3]
    top_five_5 = @merchant.top_five_customers[4]

    within("div#favorite_customers") do
      within("li#top_five_cust_#{top_five_1.id}") do
        expect(page).to have_content("#{top_five_1.first_name} #{top_five_1.last_name}")
        expect(page).to have_content("Successful Transactions: #{top_five_1.transaction_count}")
      end
      within("li#top_five_cust_#{top_five_2.id}") do
        expect(page).to have_content("#{top_five_2.first_name} #{top_five_2.last_name}")
        expect(page).to have_content("Successful Transactions: #{top_five_2.transaction_count}")
      end
      within("li#top_five_cust_#{top_five_3.id}") do
        expect(page).to have_content("#{top_five_3.first_name} #{top_five_3.last_name}")
        expect(page).to have_content("Successful Transactions: #{top_five_3.transaction_count}")
      end
      within("li#top_five_cust_#{top_five_4.id}") do
        expect(page).to have_content("#{top_five_4.first_name} #{top_five_4.last_name}")
        expect(page).to have_content("Successful Transactions: #{top_five_4.transaction_count}")
      end
      within("li#top_five_cust_#{top_five_5.id}") do
        expect(page).to have_content("#{top_five_5.first_name} #{top_five_5.last_name}")
        expect(page).to have_content("Successful Transactions: #{top_five_5.transaction_count}")
      end
    end
  end

  it 'lists invoice items ready to ship with a link to the invoice show page' do
    merchant = create(:merchant)
    items = create_list(:item, 6, merchant: merchant)
    invoices = create_list(:invoice, 2)
    inv_item_1 = create(:invoice_item, item: items[0], invoice: invoices[0], status: :packaged)
    inv_item_2 = create(:invoice_item, item: items[4], invoice: invoices[0], status: :pending)
    inv_item_3 = create(:invoice_item, item: items[3], invoice: invoices[0], status: :shipped)
    inv_item_4 = create(:invoice_item, item: items[1], invoice: invoices[0], status: :packaged)
    inv_item_5 = create(:invoice_item, item: items[2], invoice: invoices[0], status: :shipped)
    inv_item_5 = create(:invoice_item, item: items[5], invoice: invoices[1], status: :pending)

    expect(page).to have_content("Items Ready to Ship")
    
    merchant.inv_items_ready_to_ship.each do |inv_item|
      visit(merchant_dashboard_index_path(merchant.id))
      within ("li#item_ready_#{inv_item.id}")  do
        expect(page).to have_content("#{inv_item.item_name} - Invoice ##{inv_item.invoice_id}")
        expect(page).to have_link("#{inv_item.invoice_id}")

        click_link("#{inv_item.invoice_id}")

        expect(current_path).to eq(merchant_invoice_path(merchant.id, inv_item.invoice_id))
      end
    end
  end
end