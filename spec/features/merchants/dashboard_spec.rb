require 'rails_helper'

RSpec.describe 'Merchant Dashboard Page', type: :feature do

  it "lists the name of the merchant" do
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
    merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

    visit "/merchants/#{merchant1.id}/dashboard"

    within "div#merchant" do
      expect(page).to have_content("#{merchant1.name}")
    end

    visit "/merchants/#{merchant2.id}/dashboard"
    within "div#merchant" do
      expect(page).to have_content("#{merchant2.name}")
    end

    visit "/merchants/#{merchant3.id}/dashboard"
    within "div#merchant" do
      expect(page).to have_content("#{merchant3.name}")
    end
  end

  it "can show the top 5 customers by transaction count" do
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

    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("Gesley Warcia")
    expect(page).to have_content(7)
    expect(page).to have_content("Beannah Durke")
    expect(page).to have_content(6)
    expect(page).to have_content("Fasey Cazio")
    expect(page).to have_content(5)
    expect(page).to have_content("Pach Zrince")
    expect(page).to have_content(4)
    expect(page).to have_content("Tarker Phomson")
    expect(page).to have_content(3)
    expect(page).to_not have_content("Hai Sall")
    expect(page).to_not have_content(2)
    expect(page).to_not have_content("Rendolyn Guiz")
    expect(page).to_not have_content(1)
    expect('Gesley').to appear_before('Beannah')
    expect('Beannah').to appear_before('Fasey')
    expect('Fasey').to appear_before('Pach')
    expect('Pach').to appear_before('Tarker')
    expect('Tarker').to_not appear_before('Gesley')
  end
  
  it "can list a link to merchant items and invoices indexes" do
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
		merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
		merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

    item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
    item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant1.id)
    item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant2.id)
    item4 = Item.create!(name: "macrame runner", description: 'handmade macrame runner', unit_price: 2500, merchant_id: merchant3.id)

    visit "/merchants/#{merchant1.id}/dashboard"
      expect(page).to have_link("#{merchant1.name}'s Item Index")
      expect(page).to have_link("#{merchant1.name}'s Invoice Index")

    visit "/merchants/#{merchant2.id}/dashboard"
      expect(page).to have_link("#{merchant2.name}'s Item Index")
      expect(page).to have_link("#{merchant2.name}'s Invoice Index")
 
    visit "/merchants/#{merchant3.id}/dashboard"
      expect(page).to have_link("#{merchant3.name}'s Item Index")
      expect(page).to have_link("#{merchant3.name}'s Invoice Index")
  end
end

