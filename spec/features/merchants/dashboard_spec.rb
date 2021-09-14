require 'rails_helper'

describe 'merchant dashboard page' do
  before(:each) do
    @merch_1 = create(:merchant)
    @cust_1 = create(:customer)
    @cust_2 = create(:customer)
    @cust_3 = create(:customer)
    @cust_4 = create(:customer)
    @cust_5 = create(:customer)
    @cust_6 = create(:customer)
    @item_1 = create(:item, merchant: @merch_1)
    @invoice_1 = create(:invoice, customer: @cust_1)
    @invoice_2 = create(:invoice, customer: @cust_2)
    @invoice_3 = create(:invoice, customer: @cust_3)
    @invoice_4 = create(:invoice, customer: @cust_4)
    @invoice_5 = create(:invoice, customer: @cust_5)
    @invoice_6 = create(:invoice, customer: @cust_6)
    InvoiceItem.create(item: @item_1, invoice: @invoice_1)
    InvoiceItem.create(item: @item_1, invoice: @invoice_2)
    InvoiceItem.create(item: @item_1, invoice: @invoice_3)
    InvoiceItem.create(item: @item_1, invoice: @invoice_4)
    InvoiceItem.create(item: @item_1, invoice: @invoice_5)
    InvoiceItem.create(item: @item_1, invoice: @invoice_6)
    create(:transaction, invoice: @invoice_1, result: 'success')
    create(:transaction, invoice: @invoice_1, result: 'failed')
    create(:transaction, invoice: @invoice_1, result: 'failed')
    create(:transaction, invoice: @invoice_2, result: 'success')
    create(:transaction, invoice: @invoice_2, result: 'success')
    create(:transaction, invoice: @invoice_3, result: 'success')
    create(:transaction, invoice: @invoice_3, result: 'success')
    create(:transaction, invoice: @invoice_4, result: 'success')
    create(:transaction, invoice: @invoice_4, result: 'success')
    create(:transaction, invoice: @invoice_4, result: 'success')
    create(:transaction, invoice: @invoice_5, result: 'success')
    create(:transaction, invoice: @invoice_5, result: 'success')
    create(:transaction, invoice: @invoice_6, result: 'success')
    create(:transaction, invoice: @invoice_6, result: 'success')
    create(:transaction, invoice: @invoice_6, result: 'success')
    create(:transaction, invoice: @invoice_6, result: 'success')
    visit "/merchants/#{@merch_1.id}/dashboard"
  end

  it 'shows the name of the merchant' do
    expect(page).to have_content(@merch_1.name)
  end

  it 'has link to merchant items index' do
    click_link("My Items")

    expect(current_path).to eq("/merchants/#{@merch_1.id}/items")

    visit "/merchants/#{@merch_1.id}/dashboard"

    click_link("My Invoices")

    expect(current_path).to eq("/merchants/#{@merch_1.id}/invoices")
  end

  it 'shows names of top 5 customers and their successful transactions' do
    save_and_open_page
    expect(page).to_not have_content(@cust_1.first_name)

    within("#customer-#{@cust_2.id}") do
      expect(page).to have_content(@cust_2.first_name)
      expect(page).to have_content(2)
    end

    within("#customer-#{@cust_3.id}") do
      expect(page).to have_content(@cust_3.first_name)
      expect(page).to have_content(2)
    end

    within("#customer-#{@cust_4.id}") do
      expect(page).to have_content(@cust_4.first_name)
      expect(page).to have_content(3)
    end

    within("#customer-#{@cust_5.id}") do
      expect(page).to have_content(@cust_5.first_name)
      expect(page).to have_content(2)
    end

    within("#customer-#{@cust_6.id}") do
      expect(page).to have_content(@cust_6.first_name)
      expect(page).to have_content(4)
    end
  end
end
