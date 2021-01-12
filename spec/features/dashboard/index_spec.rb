require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Coon')

    @invoice_1 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(merchant_id: @merchant1.id, customer_id: @customer_6.id, status: 1)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)

    visit merchant_dashboard_index_path(@merchant1)
  end

  it 'shows the merchant name' do
    expect(page).to have_content(@merchant1.name)
  end

  it 'can see a link to my merchant items index' do
    expect(page).to have_link("Items")

    click_link "Items"

    expect(current_path).to eq("/merchant/#{@merchant1.id}/items")
  end

  it 'can see a link to my merchant invoices index' do
    expect(page).to have_link("Invoices")

    click_link "Invoices"

    expect(current_path).to eq("/merchant/#{@merchant1.id}/invoices")
  end

  it 'shows the names of the top 5 customers with successful transactions' do
    within("#customer-#{@customer_1.id}") do
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
      expect(page).to have_content(2)
    end
    within("#customer-#{@customer_2.id}") do
      expect(page).to have_content(@customer_2.first_name)
      expect(page).to have_content(@customer_2.last_name)
      expect(page).to have_content(1)
    end
    within("#customer-#{@customer_3.id}") do
      expect(page).to have_content(@customer_3.first_name)
      expect(page).to have_content(@customer_3.last_name)
      expect(page).to have_content(1)
    end
    within("#customer-#{@customer_4.id}") do
      expect(page).to have_content(@customer_4.first_name)
      expect(page).to have_content(@customer_4.last_name)
      expect(page).to have_content(1)
    end
    within("#customer-#{@customer_5.id}") do
      expect(page).to have_content(@customer_5.first_name)
      expect(page).to have_content(@customer_5.last_name)
      expect(page).to have_content(1)
    end
    expect(page).to have_no_content(@customer_6.first_name)
    expect(page).to have_no_content(@customer_6.last_name)
  end
  it "can see a section for Items Ready to Ship with list of names of items ordered and ids" do
    within("#items_ready_to_ship") do
      
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.invoice_ids)

      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_2.invoice_ids)

      expect(page).to have_no_content(@item_3.name)
      expect(page).to have_no_content(@item_3.invoice_ids)
    end
  end

  it "each invoice id is a link to my merchant's invoice show page " do
    expect(page).to have_link(@item_1.invoice_ids)
    expect(page).to have_link(@item_2.invoice_ids)
    expect(page).to_not have_link(@item_3.invoice_ids)

    click_link("#{@item_1.invoice_ids}", match: :first)
    expect(current_path).to eq("/merchant/#{@merchant1.id}/invoices/#{@invoice_1.id}")
  end

  it "shows the date that the invoice was created in this format: Monday, July 18, 2019" do
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %-d, %Y"))
  end
end
