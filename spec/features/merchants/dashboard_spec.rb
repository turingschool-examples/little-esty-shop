require 'rails_helper'

RSpec.describe 'the merchant dashboard' do
  it 'shows the name of the merchant' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')
    merchant2 = Merchant.create!(name: 'Another Merchant')

    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content('Fake Merchant')
    expect(page).to_not have_content('Another Merchant')
  end

  it 'has links to the merchants items index and merchant invoices index' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')

    visit "/merchants/#{merchant1.id}/dashboard"

    expect(current_path).to eq("/merchants/#{merchant1.id}/dashboard")
    expect(page).to have_link("My Items")
    expect(page).to have_link("My Invoices")
  end

  it 'has a section for items ready to ship' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')
    merchant2 = Merchant.create!(name: 'Dumb')

    item1 = merchant1.items.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344)
    item2 = merchant1.items.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334)
    item3 = merchant2.items.create!(name: 'Blah', description: 'bs', unit_price: 98324)

    customer1 = Customer.create!(first_name: 'Bob', last_name: 'Smith')

    invoice1 = customer1.invoices.create!(status: 2)
    invoice2 = customer1.invoices.create!(status: 2)
    invoice3 = customer1.invoices.create!(status: 0)

    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 43434, status: 1)
    invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 4, unit_price: 43434, status: 1)
    invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 4, unit_price: 43434, status: 0)
    invoice_item4 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 4, unit_price: 43434, status: 2)
    invoice_item5 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 4, unit_price: 43434, status: 1)

    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("Items Ready to Ship")
    expect(page).to have_content("Coaster - Invoice ##{invoice1.id} - #{invoice1.created_at.strftime('%A, %B %d, %Y')}")
    expect(page).to have_content("Tongs - Invoice ##{invoice2.id} - #{invoice2.created_at.strftime('%A, %B %d, %Y')}")
  end

  it 'has the top 5 customers, and the number of successful transactions they have' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')
    merchant2 = Merchant.create!(name: 'Another Merchant')

    item1 = merchant1.items.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344)
    item2 = merchant1.items.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334)
    item3 = merchant1.items.create!(name: 'knife', description: 'kitchen essential', unit_price: 28839)
    item4 = merchant1.items.create!(name: 'football', description: 'sports', unit_price: 299839)
    item5 = merchant1.items.create!(name: 'glasses', description: 'glassware', unit_price: 134634)
    item6 = merchant1.items.create!(name: 'fridge', description: 'applicance', unit_price: 288391234)
    item7 = merchant2.items.create!(name: 'chair', description: 'furniture', unit_price: 29)

    customer1 = Customer.create!(first_name: 'Robert', last_name: 'Smith')
    customer2 = Customer.create!(first_name: 'Suzie', last_name: 'Hill')
    customer3 = Customer.create!(first_name: 'Roger', last_name: 'Mathis')
    customer4 = Customer.create!(first_name: 'Jimmy', last_name: 'Ray')
    customer5 = Customer.create!(first_name: 'Molly', last_name: 'Dolly')
    customer6 = Customer.create!(first_name: 'Sara', last_name: 'Nohaira')
    customer7 = Customer.create!(first_name: 'Murray', last_name: 'Brandt')

    invoice1 = customer1.invoices.create!(status: 2)
    invoice2 = customer2.invoices.create!(status: 2)
    invoice3 = customer3.invoices.create!(status: 2)
    invoice4 = customer4.invoices.create!(status: 2)
    invoice5 = customer5.invoices.create!(status: 2)
    invoice6 = customer6.invoices.create!(status: 2)
    invoice7 = customer1.invoices.create!(status: 1)
    invoice8 = customer7.invoices.create!(status: 2)

    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 43434, status: 2)
    invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 5, unit_price: 87654, status: 2)
    invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 65666, status: 2)
    invoice_item4 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice4.id, quantity: 7, unit_price: 65666, status: 2)
    invoice_item5 = InvoiceItem.create!(item_id: item5.id, invoice_id: invoice5.id, quantity: 8, unit_price: 65666, status: 2)
    invoice_item6 = InvoiceItem.create!(item_id: item6.id, invoice_id: invoice6.id, quantity: 9, unit_price: 65666, status: 2)
    invoice_item7 = InvoiceItem.create!(item_id: item6.id, invoice_id: invoice7.id, quantity: 10, unit_price: 61236, status: 1)
    invoice_item8 = InvoiceItem.create!(item_id: item7.id, invoice_id: invoice8.id, quantity: 10, unit_price: 61299, status: 2)


    transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 1234, credit_card_expiration_date: 1234, result: 1 )
    transaction2 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 2873, credit_card_expiration_date: 1211, result: 1 )
    transaction3 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 3475, credit_card_expiration_date: 1222, result: 1 )
    transaction4 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 1173, credit_card_expiration_date: 1233, result: 1 )
    transaction5 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 2273, credit_card_expiration_date: 1244, result: 1 )
    transaction6 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 3373, credit_card_expiration_date: 1255, result: 1 )
    transaction60 = Transaction.create!(invoice_id: invoice7.id, credit_card_number: 3373, credit_card_expiration_date: 1255, result: 0 )

    transaction7 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 4473, credit_card_expiration_date: 1266, result: 1 )
    transaction8 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 5573, credit_card_expiration_date: 1277, result: 1 )
    transaction9 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 6673, credit_card_expiration_date: 1288, result: 1 )
    transaction10 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 7773, credit_card_expiration_date: 1299, result: 1 )
    transaction11 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 8873, credit_card_expiration_date: 1210, result: 1 )

    transaction12 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 8874, credit_card_expiration_date: 1210, result: 1 )
    transaction13 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 8878, credit_card_expiration_date: 1220, result: 1 )
    transaction14 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 9999, credit_card_expiration_date: 1230, result: 1 )
    transaction15 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 8888, credit_card_expiration_date: 1240, result: 1 )

    transaction16 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: 7777, credit_card_expiration_date: 1223, result: 1 )
    transaction17 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: 6666, credit_card_expiration_date: 1110, result: 1 )
    transaction18 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: 5555, credit_card_expiration_date: 1111, result: 1 )

    transaction19 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: 4444, credit_card_expiration_date: 1023, result: 1 )
    transaction20 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: 3333, credit_card_expiration_date: 1012, result: 1 )

    transaction21 = Transaction.create!(invoice_id: invoice6.id, credit_card_number: 2222, credit_card_expiration_date: 1024, result: 1 )

    transaction22 = Transaction.create!(invoice_id: invoice8.id, credit_card_number: 2629, credit_card_expiration_date: 1127, result: 1 )
    transaction23 = Transaction.create!(invoice_id: invoice8.id, credit_card_number: 2629, credit_card_expiration_date: 1127, result: 1 )
    transaction24 = Transaction.create!(invoice_id: invoice8.id, credit_card_number: 2629, credit_card_expiration_date: 1127, result: 1 )
    transaction25 = Transaction.create!(invoice_id: invoice8.id, credit_card_number: 2629, credit_card_expiration_date: 1127, result: 1 )
    transaction26 = Transaction.create!(invoice_id: invoice8.id, credit_card_number: 2629, credit_card_expiration_date: 1127, result: 1 )
    transaction27 = Transaction.create!(invoice_id: invoice8.id, credit_card_number: 2629, credit_card_expiration_date: 1127, result: 1 )

    visit "/merchants/#{merchant1.id}/dashboard"
    
    expect(current_path).to eq("/merchants/#{merchant1.id}/dashboard")
    expect(page).to have_content("Favorite Customers")
    expect(page).to have_content("Robert Smith with 6 transactions")
    expect("Robert Smith").to appear_before("Suzie Hill with 5 transactions")
    expect("Suzie Hill").to appear_before("Roger Mathis with 4 transactions")
    expect("Roger Mathis").to appear_before("Jimmy Ray with 3 transactions")
    expect("Jimmy Ray").to appear_before("Molly Dolly with 2 transactions")
    expect(page).to_not have_content("Sara Nohaira")
  end
end
