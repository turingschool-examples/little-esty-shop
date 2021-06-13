require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before(:each) do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @antimerchant = Merchant.create!(name: 'TheOtherOne')

    @customer1 = Customer.create!(first_name: 'John', last_name: 'Smith')
    @customer2 = Customer.create!(first_name: 'Julie', last_name: 'Baker')
    @customer3 = Customer.create!(first_name: 'Jared', last_name: 'Lanata')
    @customer4 = Customer.create!(first_name: 'Jira', last_name: 'Mutiu')
    @customer5 = Customer.create!(first_name: 'Josephina', last_name: 'Cortez')
    @customer6 = Customer.create!(first_name: 'Jemma', last_name: 'Henry')

    @item1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant.id)
    @item2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant.id)
    @item3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @merchant.id)
    @item4 = Item.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.2, merchant_id: @merchant.id)
    @item5 = Item.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.3, merchant_id: @merchant.id)
    @item6 = Item.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.4, merchant_id: @antimerchant.id)

    @invoice1 = Invoice.create!(status: 1, customer_id: @customer1.id, created_at: "2021-06-05 20:11:38.553871")
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer2.id, created_at: "2021-06-07 20:11:38.553871")
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer3.id, created_at: "2021-06-06 20:11:38.553871")
    @invoice4 = Invoice.create!(status: 1, customer_id: @customer4.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice5 = Invoice.create!(status: 1, customer_id: @customer5.id, created_at: "2021-06-02 20:11:38.553871")
    @invoice6 = Invoice.create!(status: 1, customer_id: @customer6.id, created_at: "2021-06-03 20:11:38.553871")

    @invoice_item1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 2, invoice_id: @invoice1.id, item_id: @item1.id)
    @invoice_item2 = InvoiceItem.create!(quantity: 5, unit_price: 16.3, status: 1, invoice_id: @invoice1.id, item_id: @item2.id, created_at: "2021-06-05 20:11:38.553871")
    @invoice_item3 = InvoiceItem.create!(quantity: 4, unit_price: 19.4, status: 2, invoice_id: @invoice2.id, item_id: @item3.id)
    @invoice_item4 = InvoiceItem.create!(quantity: 1, unit_price: 12.2, status: 2, invoice_id: @invoice2.id, item_id: @item4.id)
    @invoice_item5 = InvoiceItem.create!(quantity: 2, unit_price: 10.4, status: 2, invoice_id: @invoice2.id, item_id: @item2.id)
    @invoice_item6 = InvoiceItem.create!(quantity: 7, unit_price: 15.3, status: 1, invoice_id: @invoice3.id, item_id: @item5.id, created_at: "2021-06-06 20:11:38.553871")
    @invoice_item7 = InvoiceItem.create!(quantity: 6, unit_price: 10.4, status: 2, invoice_id: @invoice3.id, item_id: @item3.id)
    @invoice_item8 = InvoiceItem.create!(quantity: 3, unit_price: 19.4, status: 1, invoice_id: @invoice4.id, item_id: @item3.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice_item9 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 1, invoice_id: @invoice5.id, item_id: @item5.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice_item10 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 2, invoice_id: @invoice6.id, item_id: @item6.id)
    @invoice_item11 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 1, invoice_id: @invoice4.id, item_id: @item1.id, created_at: "2021-06-01 20:11:38.553871")
    @invoice_item12 = InvoiceItem.create!(quantity: 5, unit_price: 15.3, status: 2, invoice_id: @invoice4.id, item_id: @item2.id)

    @transaction1 = @invoice1.transactions.create!(result: 1, credit_card_number: 4654405418249632)
    @transaction2 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)
    @transaction3 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)

    @transaction4 = @invoice2.transactions.create!(result: 1, credit_card_number: 4923661117104166)
    @transaction5 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735617)
    @transaction6 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735617)
    @transaction7 = @invoice2.transactions.create!(result: 1, credit_card_number: 4515551623735607)

    @transaction8 = @invoice3.transactions.create!(result: 1, credit_card_number: 4203696133194408)

    @transaction9 = @invoice4.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction10 = @invoice4.transactions.create!(result: 1, credit_card_number: 4540842003561938)

    @transaction11 = @invoice5.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction12 = @invoice5.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction13 = @invoice5.transactions.create!(result: 1, credit_card_number: 4203696133194408)

    @transaction14 = @invoice6.transactions.create!(result: 1, credit_card_number: 4540842003561938)
    @transaction15 = @invoice6.transactions.create!(result: 0, credit_card_number: 4540842003561938)
    @transaction16 = @invoice6.transactions.create!(result: 0, credit_card_number: 4540842003561938)
    @transaction17 = @invoice6.transactions.create!(result: 0, credit_card_number: 4540842003561938)
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

  it 'has the top 5 customers names and how many transactions they have conducted with the merchant in question' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_content("Favorite Customers:")
    expect(page).to have_content("#{@customer1.first_name} #{@customer1.last_name}")
    expect(page).to have_content("#{@customer2.first_name} #{@customer2.last_name}")
    expect(page).to have_content("#{@customer3.first_name} #{@customer3.last_name}")
    expect(page).to have_content("#{@customer4.first_name} #{@customer4.last_name}")
    expect(page).to have_content("#{@customer5.first_name} #{@customer5.last_name}")
    expect(page).to have_no_content("#{@customer6.first_name} #{@customer6.last_name}")

    expect(page).to have_content(@customer1.top_successful_transactions(@merchant.id))
    expect(page).to have_content(@customer2.top_successful_transactions(@merchant.id))
    expect(page).to have_content(@customer3.top_successful_transactions(@merchant.id))
    expect(page).to have_content(@customer4.top_successful_transactions(@merchant.id))
    expect(page).to have_content(@customer5.top_successful_transactions(@merchant.id))
  end

  it 'has a section to display all items that have been packaged but not yet shipped' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_content("Items Ready To Ship:")
    expect(page).to have_content("#{@invoice_item2.item_name}")
    expect(page).to have_content("#{@invoice_item6.item_name}")
    expect(page).to have_content("#{@invoice_item8.item_name}")
    expect(page).to have_content("#{@invoice_item9.item_name}")
    expect(page).to have_content("#{@invoice_item11.item_name}")

  end

  it 'does not show items that have been shipped' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_no_content("#{@invoice_item4.item_name}")

  end

  it 'has the invoice id of the item listed and it is a link to the invoice show page' do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_link("#{@invoice1.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice1.id}")
    expect(page).to have_no_link("#{@invoice6.id}")
  end

  it 'has the creation date listed by each invoice in oldest to newest order' do
    visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_content("Saturday, June 05, 2021")

      expect(page).to have_content("Sunday, June 06, 2021")

      expect(page).to have_content("Tuesday, June 01, 2021")

      expect(page).to have_no_content("Thursday, June 03, 2021")

    expect("#{@invoice4.convert_create_date}").to appear_before("#{@invoice1.convert_create_date}")
    expect("#{@invoice1.convert_create_date}").to appear_before("#{@invoice3.convert_create_date}")
  end
end
