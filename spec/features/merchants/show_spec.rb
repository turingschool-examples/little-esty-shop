require 'rails_helper'

RSpec.describe 'merchant dashboard show' do

  let!(:merchant1) { Merchant.create!(name: "Schroeder-Jerde") }
  let!(:merchant2) { Merchant.create!(name: "Klein, Rempel and Jones") }
  let!(:merchant3) { Merchant.create!(name: "Willms and Sons") }

  let!(:item1) { merchant1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti", unit_price: 75107) }
  let!(:item2) { merchant1.items.create!(name: "Autem Minima", description: "Cumque consequuntur ad", unit_price: 67076) }
  let!(:item3) { merchant2.items.create!(name: "Ea Voluptatum", description: "Sunt officia", unit_price: 68723) }
  let!(:item4) { merchant2.items.create!(name: "Nemo Facere", description: "Sunt eum id eius", unit_price: 15925) }
  let!(:item5) { merchant3.items.create!(name: "Expedita Aliquam", description: "Vol pt", unit_price: 31163) }

  let!(:invoice1) { customer1.invoices.create!(status: "cancelled") }
  let!(:invoice2) { customer2.invoices.create!(status: "completed") }
  let!(:invoice3) { customer3.invoices.create!(status: "in progress") }
  let!(:invoice4) { customer4.invoices.create!(status: "completed") }
  let!(:invoice5) { customer5.invoices.create!(status: "completed") }
  let!(:invoice6) { customer5.invoices.create!(status: "in progress") }
  let!(:invoice7) { customer5.invoices.create!(status: "cancelled") }
  let!(:invoice8) { customer5.invoices.create!(status: "completed") }
  let!(:invoice9) { customer6.invoices.create!(status: "in progress") }
  let!(:invoice10) { customer6.invoices.create!(status: "cancelled") }
  let!(:invoice11) { customer6.invoices.create!(status: "cancelled") }

  let!(:invoice_item1) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 13635, status: "packaged") }
  let!(:invoice_item2) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id, quantity: 9, unit_price: 23324, status: "pending") }
  let!(:invoice_item3) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice3.id, quantity: 8, unit_price: 34873, status: "packaged") }
  let!(:invoice_item4) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice4.id, quantity: 3, unit_price: 2196, status: "packaged") }
  let!(:invoice_item5) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice5.id, quantity: 7, unit_price: 79140, status: "shipped") }
  let!(:invoice_item6) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice6.id, quantity: 3, unit_price: 52100, status: "packaged") }
  let!(:invoice_item7) { InvoiceItem.create!(item_id: item4.id, invoice_id: invoice7.id, quantity: 7, unit_price: 13635, status: "packaged") }
  let!(:invoice_item8) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice8.id, quantity: 2, unit_price: 23324, status: "pending") }
  let!(:invoice_item9) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice9.id, quantity: 4, unit_price: 34873, status: "packaged") }
  let!(:invoice_item10) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice10.id, quantity: 8, unit_price: 2196, status: "packaged") }
  let!(:invoice_item11) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice11.id, quantity: 8, unit_price: 2196, status: "packaged") }

  let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
  let!(:customer2) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }
  let!(:customer3) { Customer.create!(first_name: "Heber", last_name: "Kuhn") }
  let!(:customer4) { Customer.create!(first_name: "Mariah", last_name: "Toy") }
  let!(:customer5) { Customer.create!(first_name: "Carl", last_name: "Junior") }
  let!(:customer6) { Customer.create!(first_name: "Tony", last_name: "Bologna") }

  let!(:transaction1) { Transaction.create!(invoice_id: invoice1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "2/22", result: "success") }
  let!(:transaction2) { Transaction.create!(invoice_id: invoice2.id, credit_card_number: 4580251236515201, credit_card_expiration_date: "1/22", result: "failed") }
  let!(:transaction3) { Transaction.create!(invoice_id: invoice3.id, credit_card_number: 4354495077693036, credit_card_expiration_date: "10/22", result: "success") }
  let!(:transaction4) { Transaction.create!(invoice_id: invoice4.id, credit_card_number: 4515551623735607, credit_card_expiration_date: "4/25", result: "success") }
  let!(:transaction5) { Transaction.create!(invoice_id: invoice5.id, credit_card_number: 4844518708741275, credit_card_expiration_date: "4/23", result: "success") }
  let!(:transaction6) { Transaction.create!(invoice_id: invoice6.id, credit_card_number: 4203696133194408, credit_card_expiration_date: "5/22", result: "success") }
  let!(:transaction7) { Transaction.create!(invoice_id: invoice7.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "failed") }
  let!(:transaction8) { Transaction.create!(invoice_id: invoice8.id, credit_card_number: 4540842003561938, credit_card_expiration_date: "2/22", result: "failed") }
  let!(:transaction9) { Transaction.create!(invoice_id: invoice9.id, credit_card_number: 4140149827486249, credit_card_expiration_date: "3/22", result: "success") }
  let!(:transaction10) { Transaction.create!(invoice_id: invoice10.id, credit_card_number: 4923661117104166, credit_card_expiration_date: "2/23", result: "success") }
  let!(:transaction11) { Transaction.create!(invoice_id: invoice11.id, credit_card_number: 4923661117104166, credit_card_expiration_date: "2/23", result: "success") }

  it "displays a merchant's name" do
    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("Schroeder-Jerde")
  end

  it "displays links to a merchant's items and invoices index pages" do
    visit "/merchants/#{merchant1.id}/dashboard"

    click_link("Items Index")
    expect(current_path).to eq("/merchants/#{merchant1.id}/items")

    visit "/merchants/#{merchant1.id}/dashboard"
    click_link("Invoices Index")

    expect(current_path).to eq("/merchants/#{merchant1.id}/invoices")
  end

  # Merchant Dashboard Statistics - Favorite Customers
  # As a merchant,
  # When I visit my merchant dashboard
  # Then I see the names of the top 5 customers
  # who have conducted the largest number of successful transactions with my merchant
  # And next to each customer name I see the number of successful transactions they have
  # conducted with my merchant
  xit "displays the largest number of successful transactions with top 5 customers" do
    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("Top 5 Favorite Customers:")

    within ".favorite_customers" do
      expect(page).to have_content(customer6.first_name)
      expect(page).to have_content(customer6.last_name)
      expect(page).to have_content("Number of Successful Transactions: 3")
      expect("Number of Successful Transactions: 3").to appear_before("Customer: Carl Junior")

      expect(page).to have_content(customer5.first_name)
      expect(page).to have_content(customer5.last_name)
      expect(page).to have_content("Number of Successful Transactions: 2")
      expect("Number of Successful Transactions: 2").to appear_before("Customer: Heber Kuhn")

      expect(page).to have_content(customer3.first_name)
      expect(page).to have_content(customer3.last_name)
      expect(page).to have_content("Number of Successful Transactions: 1")
      expect("Number of Successful Transactions: 1").to appear_before("Customer: Mariah Toy")

      expect(page).to have_content(customer4.first_name)
      expect(page).to have_content(customer4.last_name)

      expect(page).to have_content(customer1.first_name)
      expect(page).to have_content(customer1.last_name)

      expect(page).to_not have_content(customer2.first_name)
      expect(page).to_not have_content(customer2.last_name)
    end
  end
end
