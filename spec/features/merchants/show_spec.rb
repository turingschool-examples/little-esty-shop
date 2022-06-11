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
  let!(:invoice12) { customer1.invoices.create!(status: "cancelled") }
  let!(:invoice13) { customer4.invoices.create!(status: "cancelled") }
  let!(:invoice14) { customer4.invoices.create!(status: "cancelled") }
  let!(:invoice15) { customer5.invoices.create!(status: "cancelled") }
  let!(:invoice16) { customer5.invoices.create!(status: "cancelled") }
  let!(:invoice17) { customer4.invoices.create!(status: "cancelled") }
  let!(:invoice18) { customer4.invoices.create!(status: "cancelled") }

  let!(:invoice_item1) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 13635, status: "packaged") }
  let!(:invoice_item2) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id, quantity: 9, unit_price: 23324, status: "pending") }
  let!(:invoice_item3) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice3.id, quantity: 8, unit_price: 34873, status: "packaged") }
  let!(:invoice_item4) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice4.id, quantity: 3, unit_price: 2196, status: "packaged") }
  let!(:invoice_item5) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice5.id, quantity: 7, unit_price: 79140, status: "shipped") }
  let!(:invoice_item6) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice6.id, quantity: 3, unit_price: 52100, status: "packaged") }
  let!(:invoice_item7) { InvoiceItem.create!(item_id: item4.id, invoice_id: invoice7.id, quantity: 7, unit_price: 13635, status: "packaged") }
  let!(:invoice_item8) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice8.id, quantity: 2, unit_price: 23324, status: "pending") }
  let!(:invoice_item9) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice9.id, quantity: 4, unit_price: 34873, status: "packaged") }
  let!(:invoice_item10) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice10.id, quantity: 8, unit_price: 2196, status: "packaged") }
  let!(:invoice_item11) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice11.id, quantity: 8, unit_price: 2196, status: "packaged") }
  let!(:invoice_item12) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice12.id, quantity: 3, unit_price: 52100, status: "packaged") }
  let!(:invoice_item13) { InvoiceItem.create!(item_id: item4.id, invoice_id: invoice13.id, quantity: 7, unit_price: 13635, status: "packaged") }
  let!(:invoice_item14) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice14.id, quantity: 2, unit_price: 23324, status: "pending") }
  let!(:invoice_item15) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice15.id, quantity: 4, unit_price: 34873, status: "packaged") }
  let!(:invoice_item16) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice16.id, quantity: 8, unit_price: 2196, status: "packaged") }
  let!(:invoice_item17) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice17.id, quantity: 8, unit_price: 2196, status: "packaged") }
  let!(:invoice_item18) { InvoiceItem.create!(item_id: item5.id, invoice_id: invoice18.id, quantity: 8, unit_price: 2196, status: "packaged") }

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
  let!(:transaction12) { Transaction.create!(invoice_id: invoice12.id, credit_card_number: 4801647818676136, credit_card_expiration_date: "5/23", result: "success") }
  let!(:transaction13) { Transaction.create!(invoice_id: invoice13.id, credit_card_number: 4540842003561938, credit_card_expiration_date: "2/22", result: "success") }
  let!(:transaction14) { Transaction.create!(invoice_id: invoice14.id, credit_card_number: 4140149827486249, credit_card_expiration_date: "3/22", result: "success") }
  let!(:transaction15) { Transaction.create!(invoice_id: invoice15.id, credit_card_number: 4923661117104166, credit_card_expiration_date: "2/23", result: "success") }
  let!(:transaction16) { Transaction.create!(invoice_id: invoice16.id, credit_card_number: 4923661117104166, credit_card_expiration_date: "2/23", result: "success") }
  let!(:transaction17) { Transaction.create!(invoice_id: invoice17.id, credit_card_number: 4923661117104166, credit_card_expiration_date: "2/23", result: "success") }
  let!(:transaction18) { Transaction.create!(invoice_id: invoice18.id, credit_card_number: 4923661117104166, credit_card_expiration_date: "2/23", result: "success") }

  it "displays a merchant's name",:vcr do
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


  it "displays the top 5 favorite customers in descending order of successful transactions" do
    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("Top 5 Favorite Customers:")

    within ".favorite_customers" do
      expect(page).to have_content("Tony Bologna - 9 Successful Transactions")
      expect(page).to have_content("Mariah Toy - 5 Successful Transactions")
      expect(page).to have_content("Carl Junior - 4 Successful Transactions")
      expect(page).to have_content("Leanne Braun - 2 Successful Transactions")
      expect(page).to have_content("Heber Kuhn - 1 Successful Transactions")

      expect("Tony Bologna").to appear_before("Mariah Toy")
      expect("Mariah Toy").to appear_before("Carl Junior")
      expect("Carl Junior").to appear_before("Leanne Braun")
      expect("Leanne Braun").to appear_before("Heber Kuhn")
    end
  end

  it "displays all merchant items ready to ship" do
    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("Items Ready to Ship:")
    within ".items_ready_to_ship" do
      expect(page).to have_content("#{item2.name}")
      expect(page).to have_link("#{invoice3.id}")
      expect(page).to have_link("#{invoice4.id}")
    end
  end
end
