require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before(:each) do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @antimerchant = Merchant.create!(name: 'TheOtherOne')

    @customer_1 = Customer.create!(first_name: 'John', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Julie', last_name: 'Baker')
    @customer_3 = Customer.create!(first_name: 'Jared', last_name: 'Lanata')
    @customer_4 = Customer.create!(first_name: 'Jira', last_name: 'Mutiu')
    @customer_5 = Customer.create!(first_name: 'Josephina', last_name: 'Cortez')
    @customer_6 = Customer.create!(first_name: 'Jemma', last_name: 'Henry')

    @item_1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant.id)
    @item_3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @merchant.id)
    @item_4 = Item.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.2, merchant_id: @merchant.id)
    @item_5 = Item.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.3, merchant_id: @merchant.id)
    @item_6 = Item.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.4, merchant_id: @antimerchant.id)

    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id, created_at: "2021-06-05 20:11:38.553871")
    @invoice_2 = Invoice.create!(status: 1, customer_id: @customer_2.id, created_at: "2021-06-07 20:11:38.553871")
    @invoice_3 = Invoice.create!(status: 1, customer_id: @customer_3.id, created_at: "2021-06-06 20:11:38.553871")
    @invoice_4 = Invoice.create!(status: 1, customer_id: @customer_4.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice_5 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: "2021-06-02 20:11:38.553871")
    @invoice_6 = Invoice.create!(status: 1, customer_id: @customer_6.id, created_at: "2021-06-03 20:11:38.553871")

    @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 2, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 16.3, status: 1, invoice_id: @invoice_1.id, item_id: @item_2.id, created_at: "2021-06-05 20:11:38.553871")
    @invoice_item_3 = InvoiceItem.create!(quantity: 4, unit_price: 19.4, status: 2, invoice_id: @invoice_2.id, item_id: @item_3.id)
    @invoice_item_4 = InvoiceItem.create!(quantity: 1, unit_price: 12.2, status: 2, invoice_id: @invoice_2.id, item_id: @item_4.id)
    @invoice_item_5 = InvoiceItem.create!(quantity: 2, unit_price: 10.4, status: 2, invoice_id: @invoice_2.id, item_id: @item_2.id)
    @invoice_item_6 = InvoiceItem.create!(quantity: 7, unit_price: 15.3, status: 1, invoice_id: @invoice_3.id, item_id: @item_5.id, created_at: "2021-06-06 20:11:38.553871")
    @invoice_item_7 = InvoiceItem.create!(quantity: 6, unit_price: 10.4, status: 2, invoice_id: @invoice_3.id, item_id: @item_3.id)
    @invoice_item_8 = InvoiceItem.create!(quantity: 3, unit_price: 19.4, status: 1, invoice_id: @invoice_4.id, item_id: @item_3.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice_item_9 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 1, invoice_id: @invoice_4.id, item_id: @item_5.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice_item_10 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 2, invoice_id: @invoice_6.id, item_id: @item_6.id)
    @invoice_item_11 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 1, invoice_id: @invoice_4.id, item_id: @item_1.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice_item_12 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 2, invoice_id: @invoice_4.id, item_id: @item_2.id)

    @transaction1 = @invoice_1.transactions.create!(result: 1, credit_card_number: 4654405418249632)
    @transaction2 = @invoice_1.transactions.create!(result: 1, credit_card_number: 4580251236515201)
    @transaction3 = @invoice_1.transactions.create!(result: 1, credit_card_number: 4580251236515201)

    @transaction4 = @invoice_2.transactions.create!(result: 1, credit_card_number: 4923661117104166)
    @transaction5 = @invoice_2.transactions.create!(result: 1, credit_card_number: 4515551623735617)
    @transaction6 = @invoice_2.transactions.create!(result: 1, credit_card_number: 4515551623735617)
    @transaction7 = @invoice_2.transactions.create!(result: 1, credit_card_number: 4515551623735607)

    @transaction8 = @invoice_3.transactions.create!(result: 1, credit_card_number: 4203696133194408)

    @transaction9 = @invoice_4.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction10 = @invoice_4.transactions.create!(result: 1, credit_card_number: 4540842003561938)

    @transaction11 = @invoice_5.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction12 = @invoice_5.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction13 = @invoice_5.transactions.create!(result: 1, credit_card_number: 4203696133194408)

    @transaction14 = @invoice_6.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction15 = @invoice_6.transactions.create!(result: 0, credit_card_number: 4540842003561938)
    @transaction16 = @invoice_6.transactions.create!(result: 0, credit_card_number: 4540842003561938)
    @transaction17 = @invoice_6.transactions.create!(result: 0, credit_card_number: 4540842003561938)
  end

  it 'shows the name of the merchant in question' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_content("#{@merchant.name}")
    expect(page).to have_no_content("#{@antimerchant.name}")
  end

  it 'has a link to my merchant items index' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_link("Merchant Items Index", href: "/merchants/#{@merchant.id}/items")
  end

  it 'has a link to my merchant invoices index' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_link("Merchant Invoice Index", href: "/merchants/#{@merchant.id}/invoices")
  end

  xit 'has the top 5 customers names and how many transactions they have conducted with the merchant in question' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_content("Favorite Customers:")
    expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
    expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name}")
    expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name}")
    expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name}")
    expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name}")
    expect(page).to have_no_content("#{@customer_6.first_name} #{@customer_6.last_name}")

    within("##{@customer_1.id}") do
      expect(page).to have_content("#{@customer_1.top_successful_transactions("#{@merchant.id}")}")
    end

    within("##{@customer_2.id}") do
      expect(page).to have_content("#{@customer_2.top_successful_transactions("#{@merchant.id}")}")
    end

    within("##{@customer_3.id}") do
      expect(page).to have_content("#{@customer_3.top_successful_transactions("#{@merchant.id}")}")
    end

    within("##{@customer_4.id}") do
      expect(page).to have_content("#{@customer_4.top_successful_transactions("#{@merchant.id}")}")
    end

    within("##{@customer_5.id}") do
      expect(page).to have_content("#{@customer_5.top_successful_transactions("#{@merchant.id}")}")
    end

    expect(page).to have_no_content("#{@customer_6.top_successful_transactions("#{@merchant.id}")}")
  end
  
  it 'has a section to display all items that have been packaged but not yet shipped' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_content("Items Ready To Ship:")
    expect(page).to have_content("#{@invoice_item_2.item_name}")
    expect(page).to have_content("#{@invoice_item_6.item_name}")
    expect(page).to have_content("#{@invoice_item_8.item_name}")
    expect(page).to have_content("#{@invoice_item_9.item_name}")
    expect(page).to have_content("#{@invoice_item_11.item_name}")

  end

  it 'does not show items that have been shipped' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_no_content("#{@invoice_item_4.item_name}")

  end

  it 'has the invoice id of the item listed and it is a link to the invoice show page' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_link("#{@invoice_1.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")
    expect(page).to have_no_link("#{@invoice_6.id}")
  end

  it 'has the creation date listed by each invoice in oldest to newest order' do
    visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_content("Saturday, June 05, 2021")

      expect(page).to have_content("Sunday, June 06, 2021")

      expect(page).to have_content("Tuesday, June 01, 2021")

      expect(page).to have_no_content("Thursday, June 03, 2021")

    expect("#{@invoice_4.convert_create_date}").to appear_before("#{@invoice_1.convert_create_date}")
    expect("#{@invoice_1.convert_create_date}").to appear_before("#{@invoice_3.convert_create_date}")
  end
end
