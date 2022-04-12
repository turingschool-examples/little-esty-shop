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

    t_1 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_2 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_3 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_4 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_5 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_6 = invoice_1.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_7 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_8 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_9 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_10 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_11 = invoice_2.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_12 = invoice_3.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_13 = invoice_3.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_14 = invoice_3.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_15 = invoice_3.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_16 = invoice_4.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_17 = invoice_4.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_18 = invoice_4.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_19 = invoice_5.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_20 = invoice_5.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
    t_21 = invoice_6.transactions.create!(credit_card_number: "*", credit_card_expiration_date: "*", result: "successful")
  visit '/admin'

    expect(page).to have_content("Bob Benson")
    expect(page).to have_content("Nate Chaffee")
    expect(page).to have_content("Barty Dasher")
    expect(page).to have_content("Zeke Bristol")
    expect(page).to have_content("Flipper McDaniel")
    expect(page).to have_no_content("Tildy Lynch")
save_and_open_page
    within("#customer-#{bob.id}") do
      expect(page).to have_content("6")
      expect(page).to have_no_content("4")
    end
  end
end
