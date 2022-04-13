require 'rails_helper'

RSpec.describe 'merchant dashboard page' do
   it 'shows the merchants name' do

        merchant_1 = Merchant.create!(name: "Geddy's Skydiving Emporium")
        visit "/merchants/#{merchant_1.id}/dashboard"
        expect(page).to have_content(merchant_1.name)
  end

  it 'links to merchant items' do
    merchant_1 = Merchant.create!(name: "Geddy's Skydiving Emporium")
    visit "/merchants/#{merchant_1.id}/dashboard"
    click_link("This Merchant's Items")
    expect(page).to have_current_path("/merchants/#{merchant_1.id}/items")
  end

  it 'links to merchant invoices' do
    merchant_1 = Merchant.create!(name: "Geddy's Skydiving Emporium")
    visit "/merchants/#{merchant_1.id}/dashboard"
    click_link("This Merchant's Invoices")
    expect(page).to have_current_path("/merchants/#{merchant_1.id}/invoices")
  end

  it 'shows the top five customers' do

    merchant = Merchant.create(name: "Braum's")
    item = merchant.items.create(name: "Beyblade", description: "Let it rip!", unit_price: 1000)

    bob = Customer.create!(first_name: "Bob", last_name: "Benson")
    nate = Customer.create!(first_name: "Nate", last_name: "Chaffee")
    barty = Customer.create!(first_name: "Barty", last_name: "Dasher")
    zeke = Customer.create!(first_name: "Zeke", last_name: "Bristol")
    flipper = Customer.create!(first_name: "Flipper", last_name: "McDaniel")
    tildy = Customer.create!(first_name: "Tildy", last_name: "Lynch")

    invoice_1 = bob.invoices.create!(status: 1)
    invoice_2 = barty.invoices.create!(status: 1)
    invoice_3 = nate.invoices.create!(status: 1)
    invoice_4 = zeke.invoices.create!(status: 1)
    invoice_5 = flipper.invoices.create!(status: 1)
    invoice_6 = tildy.invoices.create!(status: 1)

    invoice_item_1 = item.invoice_items.create(invoice_id:invoice_1.id, quantity:3, unit_price: 3000)
    invoice_item_2 = item.invoice_items.create(invoice_id:invoice_2.id, quantity:3, unit_price: 3000)
    invoice_item_3 = item.invoice_items.create(invoice_id:invoice_3.id, quantity:3, unit_price: 3000)
    invoice_item_4 = item.invoice_items.create(invoice_id:invoice_4.id, quantity:3, unit_price: 3000)
    invoice_item_5 = item.invoice_items.create(invoice_id:invoice_5.id, quantity:3, unit_price: 3000)
    invoice_item_6 = item.invoice_items.create(invoice_id:invoice_6.id, quantity:3, unit_price: 3000)


    t_1 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_2 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_3 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_4 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_5 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_6 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_7 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_8 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_9 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_10 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_11 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_12 = invoice_3.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_13 = invoice_3.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_14 = invoice_3.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_15 = invoice_3.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_16 = invoice_4.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_17 = invoice_4.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_18 = invoice_4.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_19 = invoice_5.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_20 = invoice_5.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_21 = invoice_6.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "success")
    t_22 = invoice_6.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "fail")
    t_23 = invoice_6.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "fail")
    t_24 = invoice_6.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "fail")
    t_25 = invoice_6.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "fail")
    t_26 = invoice_6.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "fail")
    t_27 = invoice_6.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "fail")
    t_28 = invoice_6.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "fail")
    t_29 = invoice_6.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "fail")
    t_30 = invoice_6.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "fail")
    t_31 = invoice_6.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "fail")
    t_32 = invoice_6.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "fail")

    visit "/merchants/#{merchant.id}/dashboard"


    expect(page).to have_content("Bob Benson")
    expect(page).to have_content("Barty Dasher")
    expect(page).to have_content("Nate Chaffee")
    expect(page).to have_content("Zeke Bristol")
    expect(page).to have_content("Flipper McDaniel")
  end
end
