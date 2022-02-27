require 'rails_helper'

RSpec.describe 'the admin dashboard' do
  it 'exists' do
    visit '/admin'
  end
#   As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a header indicating that I am on the admin dashboard
  it 'has an Admin Dashboard header' do
    visit '/admin'
    within 'header'
    expect(page).to have_content("Admin Dashboard")
  end
#   As an admin,
#   When I visit the admin dashboard (/admin)
#   Then I see a link to the admin merchants index (/admin/merchants)
#   And I see a link to the admin invoices index (/admin/invoices)
  it 'has links to the admin merchants index' do
    visit '/admin'
    within '.links'
    click_on("Merchants")
    expect(current_path).to eq("/admin/merchants")
  end

  it 'has links to the admin merchants index' do
    visit '/admin'
    within '.links'
    click_on("Invoices")
    expect(current_path).to eq("/admin/invoices")
  end

  it "I see the names of top 5 customers, and next to each name there is the number of successful transactions with this merchant" do
    customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")
    customer_2 = Customer.create!(first_name: "Person 2", last_name: "Mcperson 2")
    customer_3 = Customer.create!(first_name: "Person 3", last_name: "Mcperson 3")
    customer_4 = Customer.create!(first_name: "Person 4", last_name: "Mcperson 4")
    customer_5 = Customer.create!(first_name: "Person 5", last_name: "Mcperson 5")
    customer_6 = Customer.create!(first_name: "Person 6", last_name: "Mcperson 6")

    invoice_1 = customer_1.invoices.create!(status: "completed")
    invoice_2 = customer_1.invoices.create!(status: "completed")
    invoice_3 = customer_2.invoices.create!(status: "completed")
    invoice_4 = customer_2.invoices.create!(status: "completed")
    invoice_5 = customer_2.invoices.create!(status: "completed")
    invoice_6 = customer_3.invoices.create!(status: "completed")
    invoice_7 = customer_3.invoices.create!(status: "completed")
    invoice_8 = customer_3.invoices.create!(status: "completed")
    invoice_9 = customer_4.invoices.create!(status: "completed")
    invoice_10 = customer_4.invoices.create!(status: "completed")
    invoice_11 = customer_5.invoices.create!(status: "completed")
    invoice_12 = customer_5.invoices.create!(status: "completed")
    invoice_13 = customer_6.invoices.create!(status: "completed")
    invoice_14 = customer_6.invoices.create!(status: "completed")

    transcation_1 = invoice_1.transactions.create!(credit_card_number: "4654405418249632", result: "success")
    transcation_2 = invoice_2.transactions.create!(credit_card_number: "4654405418249634", result: "success")
    transcation_3 = invoice_3.transactions.create!(credit_card_number: "4654405418249635", result: "failed")
    transcation_4 = invoice_4.transactions.create!(credit_card_number: "4654405418249636", result: "failed")
    transcation_5 = invoice_5.transactions.create!(credit_card_number: "4654405418249637", result: "success")
    transcation_6 = invoice_6.transactions.create!(credit_card_number: "4654405418249638", result: "success")
    transcation_7 = invoice_7.transactions.create!(credit_card_number: "4654405418249639", result: "success")
    transcation_8 = invoice_8.transactions.create!(credit_card_number: "4654405418249630", result: "success")
    transcation_9 = invoice_9.transactions.create!(credit_card_number: "4654405418249612", result: "success")
    transcation_10 = invoice_10.transactions.create!(credit_card_number: "4654405418249613", result: "success")
    transcation_11 = invoice_11.transactions.create!(credit_card_number: "4654405418249614", result: "success")
    transcation_12 = invoice_12.transactions.create!(credit_card_number: "4654405418249635", result: "success")
    transcation_13 = invoice_13.transactions.create!(credit_card_number: "4654405418249635", result: "success")
    transcation_14 = invoice_14.transactions.create!(credit_card_number: "4654405418249635", result: "success")

    visit "/admin"

    within(".top_customers") do
      expect(page).to have_content("#{customer_1.name} - 2 purchases")
      expect(page).to have_content("#{customer_3.name} - 3 purchases")
      expect(page).to have_content("#{customer_4.name} - 2 purchases")
      expect(page).to have_content("#{customer_5.name} - 2 purchases")
      expect(page).to have_content("#{customer_6.name} - 2 purchases")
    end
  end

  it "has a list of all incompleted invoices with their ID, which is a link to its show page" do
    customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")

    invoice_1 = customer_1.invoices.create!(status: "in progress")
    invoice_2 = customer_1.invoices.create!(status: "in progress")
    invoice_3 = customer_1.invoices.create!(status: "completed")

    visit "/admin"

    within(".incompleted_invoices") do
      expect(page).to have_content(invoice_1.id)
      expect(page).to have_content(invoice_2.id)
      expect(page).to_not have_content(invoice_3.id)
      click_link(invoice_1.id)
      expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
    end
  end
end
