require 'rails_helper'

RSpec.describe 'Admin Merchant Index page' do
  it 'has a link to create a new merchant' do
    visit admin_merchants_path

    click_link 'Create Merchant'

    expect(current_path).to eq(admin_merchants_new_path)

    fill_in :name, with: 'Bob'
    click_button "Submit"

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content('Name: Bob')
    expect(page).to have_content('Status: Disabled')
  end

  it 'has a button to change the status of a merchant' do
    merchant1 = Merchant.create!(name: 'Alan Apple')
    merchant2 = Merchant.create!(name: 'Bob Burger')
    
    visit admin_merchants_path

    within "#id-#{merchant1.id}" do
      expect(page).to have_button("Enable/Disable")
    end

    within "#id-#{merchant2.id}" do
      expect(page).to have_button("Enable/Disable")
    end
  end

  it 'when the button is clicked it changes the status of the merchant' do
    merchant1 = Merchant.create!(name: 'Alan Apple', status: 'Enabled')
    
    visit admin_merchants_path

    within "#id-#{merchant1.id}" do
      click_button 'Enable/Disable'
      expect(page).to have_content("Status: Disabled")
    end
  end

  it 'displays the top 5 merchants based on revenue generated' do
    merchant1 = Merchant.create(name: "Bob")
    merchant2 = Merchant.create(name: "Kevin")
    merchant3 = Merchant.create(name: "Zach")

    item1 = merchant1.items.create(name: 'Mug', description: 'You can drink with it', unit_price: 5)
    item2 = merchant2.items.create(name: 'GPU', description: 'Its too expensive', unit_price: 1500)
    item3 = merchant3.items.create(name: 'Compressed Air', description: 'Its compressed', unit_price: 2)

    customer_1 = Customer.create(first_name: 'Jen', last_name: 'R')
    customer_2 = Customer.create(first_name: 'Micha', last_name: 'B')
    customer_3 = Customer.create(first_name: 'Richard', last_name: 'A')

    invoice_1 = customer_1.invoices.create(status: 'completed')
    invoice_2 = customer_2.invoices.create(status: 'completed')
    invoice_3 = customer_3.invoices.create(status: 'in progress')

    invoice_item_1 = invoice_1.invoice_items.create(item_id: item1.id, quantity: 2, unit_price: 5, status: 'shipped')
    invoice_item_2 = invoice_2.invoice_items.create(item_id: item2.id, quantity: 2, unit_price: 1500, status: 'shipped')
    invoice_item_3 = invoice_3.invoice_items.create(item_id: item3.id, quantity: 2, unit_price: 2, status: 'shipped')
    invoice_item_4 = invoice_1.invoice_items.create(item_id: item1.id, quantity: 2, unit_price: 5, status: 'shipped')
    invoice_item_5 = invoice_2.invoice_items.create(item_id: item2.id, quantity: 2, unit_price: 1500, status: 'shipped')
    invoice_item_6 = invoice_3.invoice_items.create(item_id: item3.id, quantity: 2, unit_price: 2, status: 'shipped')
    
    transaction_1 = invoice_1.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
    transaction_2 = invoice_2.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
    transaction_3 = invoice_3.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'failed')

    visit admin_merchants_path

    expect(page).to have_content('Top 5 Merchants:')
    expect('Kevin - 6000').to appear_before('Bob - 20')
    expect(page).to_not have_content('Zach - 10')
  end
end