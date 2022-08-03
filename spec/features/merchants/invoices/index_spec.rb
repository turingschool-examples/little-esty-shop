require 'rails_helper'

RSpec.describe 'Merchant Invoices Index' do
  it "has all the invoices (as links) that include the merchant's items" do
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
    merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

    item1 = Item.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344, merchant_id: merchant1.id)
    item2 = Item.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334, merchant_id: merchant1.id)
    item3 = Item.create!(name: 'knife', description: 'kitchen essential', unit_price: 28839, merchant_id: merchant1.id)
    item4 = Item.create!(name: 'football', description: 'sports', unit_price: 299839, merchant_id: merchant1.id)
    item5 = Item.create!(name: 'glasses', description: 'glassware', unit_price: 134634, merchant_id: merchant1.id)
    item6 = Item.create!(name: 'fridge', description: 'applicance', unit_price: 288391234, merchant_id: merchant1.id)
    item7 = Item.create!(name: 'chair', description: 'furniture', unit_price: 29, merchant_id: merchant2.id)

    customer1 = Customer.create!(first_name: 'Bob', last_name: 'Smith')
    customer2 = Customer.create!(first_name: 'Suzie', last_name: 'Hill')
    customer3 = Customer.create!(first_name: 'Roger', last_name: 'Mathis')
    customer4 = Customer.create!(first_name: 'Jim', last_name: 'Bob')
    customer5 = Customer.create!(first_name: 'Molly', last_name: 'Dolly')
    customer6 = Customer.create!(first_name: 'Sara', last_name: 'Nohaira')

    invoice1 = customer1.invoices.create!(status: 2)
    invoice2 = customer2.invoices.create!(status: 2)
    invoice3 = customer3.invoices.create!(status: 2)
    invoice4 = customer4.invoices.create!(status: 2)
    invoice5 = customer5.invoices.create!(status: 2)
    invoice6 = customer6.invoices.create!(status: 2)
    invoice7 = customer1.invoices.create!(status: 1)

    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 43434, status: 2)
    invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 5, unit_price: 87654, status: 2)
    invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 65666, status: 2)
    invoice_item4 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice4.id, quantity: 7, unit_price: 65666, status: 2)
    invoice_item5 = InvoiceItem.create!(item_id: item5.id, invoice_id: invoice5.id, quantity: 8, unit_price: 65666, status: 2)
    invoice_item6 = InvoiceItem.create!(item_id: item6.id, invoice_id: invoice6.id, quantity: 9, unit_price: 65666, status: 2)
    invoice_item7 = InvoiceItem.create!(item_id: item7.id, invoice_id: invoice7.id, quantity: 10, unit_price: 61236, status: 0)

    transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '5549613027481234', result: 1 )
    transaction2 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '5549613027482873', result: 1 )
    transaction3 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '5549613027483475', result: 1 )
    transaction4 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '5549613027481173', result: 1 )
    transaction5 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '5549613027482273', result: 1 )
    transaction6 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '5549613027483373', result: 1 )

    transaction7 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '5549613027484473', result: 1 )
    transaction8 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '5549613027485573', result: 1 )
    transaction9 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '5549613027486673', result: 1 )
    transaction10 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '5549613027487773', result: 1 )
    transaction11 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '5549613027488873', result: 1 )

    transaction12 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '5549613027488874', result: 1 )
    transaction13 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '5549613027488878', result: 1 )
    transaction14 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '5549613027489999', result: 1 )
    transaction15 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '5549613027488888', result: 1 )

    transaction16 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: '5549613027487777', result: 1 )
    transaction17 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: '5549613027486666', result: 1 )
    transaction18 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: '5549613027485555', result: 1 )

    transaction19 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: '5549613027484444', result: 1 )
    transaction20 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: '5549613027483333', result: 1 )

    transaction21 = Transaction.create!(invoice_id: invoice6.id, credit_card_number: '5549613027482222', result: 1 )

    visit "/merchants/#{merchant1.id}/invoices"

    # expect(page).to have_content("Fake Merchant")

    # within "#invoice-" do
    expect(page).to have_content("Invoice")
    expect(page).to have_link("#{invoice1.id}")
    expect(page).to have_link("#{invoice2.id}")
    expect(page).to have_link("#{invoice3.id}")
    expect(page).to have_link("#{invoice4.id}")
    expect(page).to have_link("#{invoice5.id}")
    expect(page).to have_link("#{invoice6.id}")
    expect(page).to_not have_link("#{invoice7.id}")
  end

  it "links to the invoice show page" do
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
    merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

    item1 = Item.create!(name: 'Coaster', description: 'For day drinking', unit_price: 74344, merchant_id: merchant1.id)
    item2 = Item.create!(name: 'Tongs', description: 'For ice buckets', unit_price: 98334, merchant_id: merchant1.id)
    item3 = Item.create!(name: 'knife', description: 'kitchen essential', unit_price: 28839, merchant_id: merchant1.id)
    item4 = Item.create!(name: 'football', description: 'sports', unit_price: 299839, merchant_id: merchant1.id)
    item5 = Item.create!(name: 'glasses', description: 'glassware', unit_price: 134634, merchant_id: merchant1.id)
    item6 = Item.create!(name: 'fridge', description: 'applicance', unit_price: 288391234, merchant_id: merchant1.id)
    item7 = Item.create!(name: 'chair', description: 'furniture', unit_price: 29, merchant_id: merchant2.id)

    customer1 = Customer.create!(first_name: 'Bob', last_name: 'Smith')
    customer2 = Customer.create!(first_name: 'Suzie', last_name: 'Hill')
    customer3 = Customer.create!(first_name: 'Roger', last_name: 'Mathis')
    customer4 = Customer.create!(first_name: 'Jim', last_name: 'Bob')
    customer5 = Customer.create!(first_name: 'Molly', last_name: 'Dolly')
    customer6 = Customer.create!(first_name: 'Sara', last_name: 'Nohaira')

    invoice1 = customer1.invoices.create!(status: 2)
    invoice2 = customer2.invoices.create!(status: 2)
    invoice3 = customer3.invoices.create!(status: 2)
    invoice4 = customer4.invoices.create!(status: 2)
    invoice5 = customer5.invoices.create!(status: 2)
    invoice6 = customer6.invoices.create!(status: 2)
    invoice7 = customer1.invoices.create!(status: 1)

    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 43434, status: 2)
    invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 5, unit_price: 87654, status: 2)
    invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 65666, status: 2)
    invoice_item4 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice4.id, quantity: 7, unit_price: 65666, status: 2)
    invoice_item5 = InvoiceItem.create!(item_id: item5.id, invoice_id: invoice5.id, quantity: 8, unit_price: 65666, status: 2)
    invoice_item6 = InvoiceItem.create!(item_id: item6.id, invoice_id: invoice6.id, quantity: 9, unit_price: 65666, status: 2)
    invoice_item7 = InvoiceItem.create!(item_id: item7.id, invoice_id: invoice7.id, quantity: 10, unit_price: 61236, status: 0)

    invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 4, unit_price: 43434, status: 2)
    invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 5, unit_price: 87654, status: 2)
    invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 6, unit_price: 65666, status: 2)
    invoice_item4 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice4.id, quantity: 7, unit_price: 65666, status: 2)
    invoice_item5 = InvoiceItem.create!(item_id: item5.id, invoice_id: invoice5.id, quantity: 8, unit_price: 65666, status: 2)
    invoice_item6 = InvoiceItem.create!(item_id: item6.id, invoice_id: invoice6.id, quantity: 9, unit_price: 65666, status: 2)
    invoice_item7 = InvoiceItem.create!(item_id: item7.id, invoice_id: invoice7.id, quantity: 10, unit_price: 61236, status: 0)

    transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '5549613027481234', result: 1 )
    transaction2 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '5549613027482873', result: 1 )
    transaction3 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '5549613027483475', result: 1 )
    transaction4 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '5549613027481173', result: 1 )
    transaction5 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '5549613027482273', result: 1 )
    transaction6 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '5549613027483373', result: 1 )

    transaction7 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '5549613027484473', result: 1 )
    transaction8 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '5549613027485573', result: 1 )
    transaction9 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '5549613027486673', result: 1 )
    transaction10 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '5549613027487773', result: 1 )
    transaction11 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '5549613027488873', result: 1 )

    transaction12 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '5549613027488874', result: 1 )
    transaction13 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '5549613027488878', result: 1 )
    transaction14 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '5549613027489999', result: 1 )
    transaction15 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '5549613027488888', result: 1 )

    transaction16 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: '5549613027487777', result: 1 )
    transaction17 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: '5549613027486666', result: 1 )
    transaction18 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: '5549613027485555', result: 1 )

    transaction19 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: '5549613027484444', result: 1 )
    transaction20 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: '5549613027483333', result: 1 )

    transaction21 = Transaction.create!(invoice_id: invoice6.id, credit_card_number: '5549613027482222', result: 1 )

    visit "/merchants/#{merchant1.id}/invoices"

    click_link("#{invoice1.id}", match: :first)
    expect(current_path).to eq("/merchants/#{merchant1.id}/invoices/#{invoice1.id}")
  end
end
