require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  it 'displays a header indicating that user is on the admin dashboard' do
    visit '/admin'
    # save_and_open_page
    within(".header") do
      expect(page).to have_content("Admin Dashboard")
    end
  end

  it 'displays link to admin merchant index' do
    visit '/admin'
    within(".link_bar") do
      expect(page).to have_link("Admin Merchants")
    end
    click_link "Admin Merchants"
    expect(current_path).to eq('/admin/merchants')
  end

  it 'displays link to admin invoices index' do
    visit '/admin'
    within(".link_bar") do
      expect(page).to have_link("Admin Invoices")
    end
    click_link "Admin Invoices"
    expect(current_path).to eq('/admin/invoices')
  end

  it 'displays the names of top 5 customers' do
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
    visit '/admin'

    expect(page).to have_content("Bob Benson")
    expect(page).to have_content("Nate Chaffee")
    expect(page).to have_content("Barty Dasher")
    expect(page).to have_content("Zeke Bristol")
    expect(page).to have_content("Flipper McDaniel")
    expect(page).to have_no_content("Tildy Lynch")
    within("#customer-#{bob.id}") do
      expect(page).to have_content("6")
      expect(page).to have_no_content("4")
    end
  end

  it 'displays the ids of incomplete invoices' do
    walmart = Merchant.create!(name: "Wal-Mart")
    bob = Customer.create!(first_name: "Bob", last_name: "Benson")
    item_1 = walmart.items.create!(name: "pickle", description: "sour cucumber", unit_price: 300)
    item_2 = walmart.items.create!(name: "eraser", description: "rubber bit", unit_price: 200)
    item_3 = walmart.items.create!(name: "candle", description: "beeswax", unit_price: 1000)
    item_4 = walmart.items.create!(name: "calculator", description: "scientific", unit_price: 2000)
    item_5 = walmart.items.create!(name: "ball", description: "soccer", unit_price: 900)
    item_6 = walmart.items.create!(name: "notebook", description: "leatherbound", unit_price: 2500)
    item_7 = walmart.items.create!(name: "wine glass", description: "stemless", unit_price: 350)
    item_8 = walmart.items.create!(name: "banjo", description: "five string", unit_price: 30100)
    item_9 = walmart.items.create!(name: "golf tees", description: "2 1/2 inch", unit_price: 100)
    item_10 = walmart.items.create!(name: "radio", description: "AM/FM", unit_price: 900)
    item_11 = walmart.items.create!(name: "adult diaper", description: "family size", unit_price: 400)
    invoice_1 = bob.invoices.create!(status: 1)
    invoice_2 = bob.invoices.create!(status: 1)
    invoice_3 = bob.invoices.create!(status: 1)
    invoice_4 = bob.invoices.create!(status: 1)
    invoice_5 = bob.invoices.create!(status: 1)
    invoice_6 = bob.invoices.create!(status: 1)
    invoice_7 = bob.invoices.create!(status: 1)
    invoice_8 = bob.invoices.create!(status: 1)
    invoice_9 = bob.invoices.create!(status: 1)
    invoice_10 = bob.invoices.create!(status: 1)
    invoice_11 = bob.invoices.create!(status: 1)
    InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, status: 1)
    InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, status: 2)
    InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, status: 2)
    InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, status: 0)
    InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, status: 2)
    InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, status: 2)
    InvoiceItem.create!(invoice_id: invoice_7.id, item_id: item_7.id, quantity: 1, status: 1)
    InvoiceItem.create!(invoice_id: invoice_8.id, item_id: item_8.id, quantity: 1, status: 0)
    InvoiceItem.create!(invoice_id: invoice_9.id, item_id: item_9.id, quantity: 1, status: 2)
    InvoiceItem.create!(invoice_id: invoice_10.id, item_id: item_10.id, quantity: 1, status: 2)
    InvoiceItem.create!(invoice_id: invoice_11.id, item_id: item_11.id, quantity: 1, status: 2)

    visit '/admin'

    expect(page).to have_content(invoice_1.id)
    expect(page).to have_content(invoice_4.id)
    expect(page).to have_content(invoice_7.id)
    expect(page).to have_content(invoice_8.id)
    expect(page).to have_no_content(invoice_2.id)
    expect(page).to have_no_content(invoice_3.id)
    expect(page).to have_no_content(invoice_5.id)

    click_link invoice_1.id
    expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
  end

end
