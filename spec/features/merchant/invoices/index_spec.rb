require 'rails_helper'

RSpec.describe 'Merchant Invoices Index Page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)
    @item_4 = create(:item, merchant_id: @merchant_1.id)
    @item_5 = create(:item, merchant_id: @merchant_1.id)
    @item_6 = create(:item, name: "Does not belong to merchant 1", merchant_id: @merchant_2.id)
    
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id)
    @invoice_3 = create(:invoice, customer_id: @customer_2.id)
    @invoice_4 = create(:invoice, customer_id: @customer_3.id)
    @invoice_5 = create(:invoice, customer_id: @customer_4.id)
    @invoice_6 = create(:invoice, customer_id: @customer_5.id)
    @invoice_7 = create(:invoice, customer_id: @customer_6.id)
    @invoice_8 = create(:invoice, customer_id: @customer_6.id)
    
    @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: true) #customer_1 
    @transaction_2 = create(:transaction, invoice_id: @invoice_1.id, result: true) #customer_1
    @transaction_3 = create(:transaction, invoice_id: @invoice_2.id, result: true) #customer_1
    @transaction_4 = create(:transaction, invoice_id: @invoice_2.id, result: true) #customer_1
    @transaction_5 = create(:transaction, invoice_id: @invoice_2.id, result: true) #customer_1
    @transaction_6 = create(:transaction, invoice_id: @invoice_2.id, result: true) #customer_1
    @transaction_7 = create(:transaction, invoice_id: @invoice_3.id, result: true) #customer_2
    @transaction_8 = create(:transaction, invoice_id: @invoice_3.id, result: true) #customer_2
    @transaction_9 = create(:transaction, invoice_id: @invoice_3.id, result: true) #customer_2
    @transaction_10 = create(:transaction, invoice_id: @invoice_3.id, result: true) #customer_2
    @transaction_11 = create(:transaction, invoice_id: @invoice_3.id, result: true) #customer_2
    @transaction_12 = create(:transaction, invoice_id: @invoice_4.id, result: true) #customer_3
    @transaction_13 = create(:transaction, invoice_id: @invoice_4.id, result: true) #customer_3
    @transaction_14 = create(:transaction, invoice_id: @invoice_4.id, result: true) #customer_3
    @transaction_15 = create(:transaction, invoice_id: @invoice_4.id, result: true) #customer_3
    @transaction_16 = create(:transaction, invoice_id: @invoice_5.id, result: true) #customer_4
    @transaction_17 = create(:transaction, invoice_id: @invoice_5.id, result: true) #customer_4
    @transaction_18 = create(:transaction, invoice_id: @invoice_5.id, result: true) #customer_4
    @transaction_19 = create(:transaction, invoice_id: @invoice_6.id, result: true) #customer_5
    @transaction_20 = create(:transaction, invoice_id: @invoice_6.id, result: true) #customer_5
    @transaction_21 = create(:transaction, invoice_id: @invoice_6.id, result: false) #customer_5
    @transaction_22 = create(:transaction, invoice_id: @invoice_7.id, result: true) #customer_6
    @transaction_23 = create(:transaction, invoice_id: @invoice_7.id, result: false) #customer_6

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 0)
    @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, status: 0)
    @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id, status: 1)
    @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, status: 1)
    @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, status: 2)
    @invoice_item_6 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_6.id, status: 2)
    @invoice_item_7 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_7.id, status: 2)
    @invoice_item_8 = create(:invoice_item, item_id: @item_6.id, invoice_id: @invoice_8.id, status: 0)

    visit merchant_invoices_path(@merchant_1.id)
  end

  it 'has a header' do
    expect(page).to have_content("#{@merchant_1.name} Invoices")
  end

  it 'it has invoice ids as links, User Story 14' do
    within "#invoice-#{@invoice_1.id}" do
      expect(page).to have_link("ID: #{@invoice_1.id}")
    end
  end

  it 'when I visit a merchant invoice index page, I see all invoices with at least one of my merchant items (User Story 14)' do
    expect(page).to have_link("ID: #{@invoice_1.id}")
    expect(page).to have_link("ID: #{@invoice_2.id}")
    expect(page).to have_link("ID: #{@invoice_3.id}")
    expect(page).to have_link("ID: #{@invoice_4.id}")
    expect(page).to have_link("ID: #{@invoice_5.id}")
    expect(page).to have_link("ID: #{@invoice_6.id}")
    expect(page).to have_link("ID: #{@invoice_7.id}")
    expect(page).to_not have_link("ID: #{@invoice_8.id}")
  end
end
