require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do

 it "has a header indicating this is the admin dashboard" do

  visit '/admin'

  expect(page).to have_content('Admin Dashboard')
 end

 it "has links to the admin merchants and invoices indexes" do

  visit '/admin'

  expect(page).to have_link('Admin Merchants Index')
  expect(page).to have_link('Admin Invoices Index')
 end

# Admin Dashboard Statistics - Top Customers

# As an admin,
# When I visit the admin dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions
# And next to each customer name I see the number of successful transactions they have
# conducted

  it "shows the names of the top 5 customers who have conducted the largest number of successful
  transactions and next to each customer name I see the number of successful transactions they
  have conducted" do
    merchant1 = Merchant.create!(name: 'Poke pics')

    item1 = Item.create!(name: 'Pikachu Pics', description: 'Pics with PIKACHU', unit_price: 1500, merchant_id: merchant1.id)

    customer1 = Customer.create!(first_name: 'Beannah', last_name: 'Durke')
    customer2 = Customer.create!(first_name: 'Tarker', last_name: 'Phomson')
    customer3 = Customer.create!(first_name: 'Hai', last_name: 'Sall')
    customer4 = Customer.create!(first_name: 'Pach', last_name: 'Zrince')
    customer5 = Customer.create!(first_name: 'Fasey', last_name: 'Cazio')
    customer6 = Customer.create!(first_name: 'Gesley', last_name: 'Warcia')
    customer7 = Customer.create!(first_name: 'Rendolyn', last_name: 'Guiz')

    invoice1 = Invoice.create!(status: 'completed', customer_id: customer1.id)
    invoice2 = Invoice.create!(status: 'completed', customer_id: customer2.id)
    invoice3 = Invoice.create!(status: 'completed', customer_id: customer3.id)
    invoice4 = Invoice.create!(status: 'completed', customer_id: customer4.id)
    invoice5 = Invoice.create!(status: 'completed', customer_id: customer5.id)
    invoice6 = Invoice.create!(status: 'completed', customer_id: customer6.id)
    invoice7 = Invoice.create!(status: 'completed', customer_id: customer7.id)

    invoice_item1 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice2.id)
    invoice_item3 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice3.id)
    invoice_item4 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice4.id)
    invoice_item5 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice5.id)
    invoice_item6 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice6.id)
    invoice_item7 = InvoiceItem.create!(quantity: 100, unit_price: 1000, status: 'shipped', item_id: item1.id, invoice_id: invoice7.id)

    transaction1 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
    transaction2 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
    transaction3 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
    transaction4 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
    transaction5 = Transaction.create!(result: 'success', invoice_id: invoice1.id)
    transaction6 = Transaction.create!(result: 'success', invoice_id: invoice1.id)

    transaction7 = Transaction.create!(result: 'success', invoice_id: invoice2.id)
    transaction8 = Transaction.create!(result: 'success', invoice_id: invoice2.id)
    transaction9 = Transaction.create!(result: 'success', invoice_id: invoice2.id)

    transaction10 = Transaction.create!(result: 'success', invoice_id: invoice3.id)
    transaction11 = Transaction.create!(result: 'success', invoice_id: invoice3.id)

    transaction12 = Transaction.create!(result: 'success', invoice_id: invoice4.id)
    transaction13 = Transaction.create!(result: 'success', invoice_id: invoice4.id)
    transaction14 = Transaction.create!(result: 'success', invoice_id: invoice4.id)
    transaction15 = Transaction.create!(result: 'success', invoice_id: invoice4.id)

    transaction16 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
    transaction17 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
    transaction18 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
    transaction19 = Transaction.create!(result: 'success', invoice_id: invoice5.id)
    transaction20 = Transaction.create!(result: 'success', invoice_id: invoice5.id)

    transaction21 = Transaction.create!(result: 'success', invoice_id: invoice6.id)
    transaction22 = Transaction.create!(result: 'success', invoice_id: invoice6.id)
    transaction23 = Transaction.create!(result: 'success', invoice_id: invoice6.id)
    transaction24 = Transaction.create!(result: 'success', invoice_id: invoice6.id)
    transaction25 = Transaction.create!(result: 'success', invoice_id: invoice6.id)
    transaction26 = Transaction.create!(result: 'success', invoice_id: invoice6.id)
    transaction27 = Transaction.create!(result: 'success', invoice_id: invoice6.id)

    transaction28 = Transaction.create!(result: 'success', invoice_id: invoice7.id)

    visit "/admin"

    expect(page).to have_content("Gesley Warcia Number of transactions: 7")
    expect(page).to have_content("Beannah Durke Number of transactions: 6")
    expect(page).to have_content("Fasey Cazio Number of transactions: 5")
    expect(page).to have_content("Pach Zrince Number of transactions: 4")
    expect(page).to have_content("Tarker Phomson Number of transactions: 3")
    expect(page).to_not have_content("Hai Sall")
    expect(page).to_not have_content("Rendolyn Guiz")
    expect('Gesley').to appear_before('Beannah')
    expect('Beannah').to appear_before('Fasey')
    expect('Fasey').to appear_before('Pach')
    expect('Pach').to appear_before('Tarker')
    expect('Tarker').to_not appear_before('Gesley')
  end

 it "can list incomplete invoices and link to the invoice's admin show page" do
    merchant1 = Merchant.create!(name: "Poke Retirement homes", status: "enabled")
    merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops", status: "enabled")
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits", status: "enabled")

    item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
    item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant1.id)
    item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant2.id)
    item4 = Item.create!(name: "Pencil", description: 'Writes things down', unit_price: 100, merchant_id: merchant2.id)
    item5 = Item.create!(name: "Chair", description: 'To sit on', unit_price: 7500, merchant_id: merchant2.id)
    item6 = Item.create!(name: "Blanket", description: 'Keeps you warm', unit_price: 2500, merchant_id: merchant3.id)
    item7 = Item.create!(name: "shoe", description: 'leather', unit_price: 3500, merchant_id: merchant3.id)

    customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
    invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice3 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice4 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice5 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice6 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice7 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice8 = Invoice.create!(status: "completed", customer_id: customer1.id)

    invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "packaged", item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = InvoiceItem.create!(quantity: 1, unit_price: item2.unit_price, status: "packaged", item_id: item2.id, invoice_id: invoice2.id)
    invoice_item3 = InvoiceItem.create!(quantity: 1, unit_price: item3.unit_price, status: "pending", item_id: item3.id, invoice_id: invoice3.id)
    invoice_item4 = InvoiceItem.create!(quantity: 1, unit_price: item4.unit_price, status: "pending", item_id: item4.id, invoice_id: invoice4.id)
    invoice_item5 = InvoiceItem.create!(quantity: 1, unit_price: item5.unit_price, status: "pending", item_id: item5.id, invoice_id: invoice5.id)
    invoice_item6 = InvoiceItem.create!(quantity: 1, unit_price: item6.unit_price, status: "packaged", item_id: item6.id, invoice_id: invoice6.id)
    invoice_item7 = InvoiceItem.create!(quantity: 1, unit_price: item7.unit_price, status: "shipped", item_id: item7.id, invoice_id: invoice7.id)
    invoice_item8 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item7.id, invoice_id: invoice8.id)

    visit '/admin'
    expect(page).to have_content("Incomplete Invoices")

    within '#incomplete_invoices' do
      expect(page).to have_content("#{invoice1.id}")
      expect(page).to have_content("#{invoice2.id}")
      expect(page).to have_content("#{invoice3.id}")
      expect(page).to have_content("#{invoice4.id}")
      expect(page).to have_content("#{invoice5.id}")
      expect(page).to have_content("#{invoice6.id}")

      expect(page).to_not have_content("#{invoice7.id}")
      expect(page).to_not have_content("#{invoice8.id}")

      expect(page).to have_link("#{invoice2.id}")
      click_on("#{invoice2.id}")
      expect(current_path).to eq("/admin/invoices/#{invoice2.id}")
    end
  end

  it 'in the Incomplete Invoices section, next to each invoice id i see the date that the invoice
  was created and I see the date formatted like Monday, July 18, 2019. And I see that the list
  is ordered from oldest to newest' do
    merchant1 = Merchant.create!(name: "Poke Retirement homes", status: "enabled")
    merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops", status: "enabled")
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits", status: "enabled")

    item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
    item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant1.id)
    item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant2.id)
    item4 = Item.create!(name: "Pencil", description: 'Writes things down', unit_price: 100, merchant_id: merchant2.id)
    item5 = Item.create!(name: "Chair", description: 'To sit on', unit_price: 7500, merchant_id: merchant2.id)
    item6 = Item.create!(name: "Blanket", description: 'Keeps you warm', unit_price: 2500, merchant_id: merchant3.id)
    item7 = Item.create!(name: "shoe", description: 'leather', unit_price: 3500, merchant_id: merchant3.id)

    customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
    invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-07-01 20:00:00 UTC -05:00")
    invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-07-02 20:00:00 UTC -05:00")
    invoice3 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-06-01 20:00:00 UTC -05:00")
    invoice4 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-05-01 20:00:00 UTC -05:00")
    invoice5 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-05-18 20:00:00 UTC -05:00")
    invoice6 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-07-22 20:00:00 UTC -05:00")
    invoice7 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-06-11 20:00:00 UTC -05:00")
    invoice8 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-07-03 20:00:00 UTC -05:00")

    invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "packaged", item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = InvoiceItem.create!(quantity: 1, unit_price: item2.unit_price, status: "packaged", item_id: item2.id, invoice_id: invoice2.id)
    invoice_item3 = InvoiceItem.create!(quantity: 1, unit_price: item3.unit_price, status: "pending", item_id: item3.id, invoice_id: invoice3.id)
    invoice_item4 = InvoiceItem.create!(quantity: 1, unit_price: item4.unit_price, status: "pending", item_id: item4.id, invoice_id: invoice4.id)
    invoice_item5 = InvoiceItem.create!(quantity: 1, unit_price: item5.unit_price, status: "pending", item_id: item5.id, invoice_id: invoice5.id)
    invoice_item6 = InvoiceItem.create!(quantity: 1, unit_price: item6.unit_price, status: "packaged", item_id: item6.id, invoice_id: invoice6.id)
    invoice_item7 = InvoiceItem.create!(quantity: 1, unit_price: item7.unit_price, status: "shipped", item_id: item7.id, invoice_id: invoice7.id)
    invoice_item8 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item7.id, invoice_id: invoice8.id)

    visit '/admin'

    within '#incomplete_invoices' do
      expect(page).to have_content("#{invoice1.id} Date invoice created: Friday, July 01, 2022")
      expect(page).to have_content("#{invoice2.id} Date invoice created: Saturday, July 02, 2022")
      expect(page).to have_content("#{invoice3.id} Date invoice created: Wednesday, June 01, 2022")
      expect(page).to have_content("#{invoice4.id} Date invoice created: Sunday, May 01, 2022")
      expect(page).to have_content("#{invoice5.id} Date invoice created: Wednesday, May 18, 2022")
      expect(page).to have_content("#{invoice6.id} Date invoice created: Friday, July 22, 2022")

      expect(page).to_not have_content("#{invoice7.id}")
      expect(page).to_not have_content("#{invoice8.id}")
      expect("#{invoice4.id}").to appear_before("#{invoice5.id}")
      expect("#{invoice5.id}").to appear_before("#{invoice3.id}")
      expect("#{invoice3.id}").to appear_before("#{invoice1.id}")
      expect("#{invoice1.id}").to appear_before("#{invoice2.id}")
      expect("#{invoice2.id}").to appear_before("#{invoice6.id}")
    end
  end
end
