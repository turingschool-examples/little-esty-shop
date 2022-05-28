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

  let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
  let!(:customer2) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }
  let!(:customer3) { Customer.create!(first_name: "Heber", last_name: "Kuhn") }
  let!(:customer4) { Customer.create!(first_name: "Mariah", last_name: "Toy") }
  let!(:customer5) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
  let!(:customer6) { Customer.create!(first_name: "Tony", last_name: "Bologna") }

  let!(:transaction1) { Transaction.create!(invoice_id: invoice1.id, credit_card_number: 4654405418249632, result: "success") }
  let!(:transaction2) { Transaction.create!(invoice_id: invoice2.id, credit_card_number: 4580251236515201, result: "success") }
  let!(:transaction3) { Transaction.create!(invoice_id: invoice3.id, credit_card_number: 4354495077693036, result: "success") }
  let!(:transaction4) { Transaction.create!(invoice_id: invoice4.id, credit_card_number: 4515551623735607, result: "success") }
  let!(:transaction5) { Transaction.create!(invoice_id: invoice5.id, credit_card_number: 4844518708741275, result: "success") }
  let!(:transaction6) { Transaction.create!(invoice_id: invoice6.id, credit_card_number: 4203696133194408, result: "success") }
  let!(:transaction7) { Transaction.create!(invoice_id: invoice7.id, credit_card_number: 4801647818676136, result: "failed") }
  let!(:transaction8) { Transaction.create!(invoice_id: invoice8.id, credit_card_number: 4540842003561938, result: "failed") }
  let!(:transaction9) { Transaction.create!(invoice_id: invoice9.id, credit_card_number: 4140149827486249, result: "success") }
  let!(:transaction10) { Transaction.create!(invoice_id: invoice10.id, credit_card_number: 4923661117104166, result: "success") }

  it "displays a merchant's name" do
    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("Schroeder-Jerde")
  end

  it "displays links to a merchant's items and invoices index pages" do
    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("Items Index")
    expect(page).to have_content("Invoices Index")
  end

  # Merchant Dashboard Statistics - Favorite Customers
  # As a merchant,
  # When I visit my merchant dashboard
  # Then I see the names of the top 5 customers
  # who have conducted the largest number of successful transactions with my merchant
  # And next to each customer name I see the number of successful transactions they have
  # conducted with my merchant
  it "displays the largest number of successful transactions with top 5 customers" do
    visit "/merchants/#{merchant1.id}/dashboard"
require "pry"; binding.pry
    expect(page).to have_content("Top 5 Favorite Customers: ")

    within "#customer-#{customer1.id}" do
      expect(page).to have_content(customer1.name)
      expect(page).to have_content("Number of Successful Transactions: ")
    end

    within "#customer-#{customer2.id}" do
      expect(page).to have_content(customer2.name)
      expect(page).to have_content("Number of Successful Transactions: ")
    end

    within "#customer-#{customer3.id}" do
      expect(page).to have_content(customer3.name)
      expect(page).to have_content("Number of Successful Transactions: ")
    end

    within "#customer-#{customer4.id}" do
      expect(page).to have_content(customer4.name)
      expect(page).to have_content("Number of Successful Transactions: ")
    end

    within "#customer-#{customer5.id}" do
      expect(page).to have_content(customer5.name)
      expect(page).to have_content("Number of Successful Transactions: ")
    end
  end
end
