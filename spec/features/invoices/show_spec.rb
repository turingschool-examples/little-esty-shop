require 'rails_helper'

RSpec.describe "Merchant Invoices Show Page" do
  let!(:merchant1) { Merchant.create!(name: "Schroeder-Jerde") }
  let!(:merchant2) { Merchant.create!(name: "Klein, Rempel and Jones") }
  let!(:merchant3) { Merchant.create!(name: "Willms and Sons") }

  let!(:discount1) { merchant1.discounts.create!(percentage: 20, quantity_threshold: 3) }
  let!(:discount2) { merchant1.discounts.create!(percentage: 50, quantity_threshold: 5) }
  let!(:discount3) { merchant2.discounts.create!(percentage: 60, quantity_threshold: 5) }

  let!(:item1) { merchant1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti", unit_price: 75107) }
  let!(:item2) { merchant1.items.create!(name: "Autem Minima", description: "Cumque consequuntur ad", unit_price: 67076) }
  let!(:item3) { merchant2.items.create!(name: "Ea Voluptatum", description: "Sunt officia", unit_price: 68723) }
  let!(:item4) { merchant2.items.create!(name: "Nemo Facere", description: "Sunt eum id eius", unit_price: 15925) }
  let!(:item5) { merchant3.items.create!(name: "Expedita Aliquam", description: "Vol pt", unit_price: 31163) }

  let!(:invoice1) { customer1.invoices.create!(status: "in progress") }
  let!(:invoice2) { customer2.invoices.create!(status: "completed") }

  let!(:invoice_item1) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 13635, status: "packaged") }
  let!(:invoice_item2) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id, quantity: 9, unit_price: 23324, status: "pending") }
  let!(:invoice_item19) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 9, unit_price: 23324, status: "packaged") }

  let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
  let!(:customer2) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }
  let!(:customer3) { Customer.create!(first_name: "Heber", last_name: "Kuhn") }
  let!(:customer4) { Customer.create!(first_name: "Mariah", last_name: "Toy") }
  let!(:customer5) { Customer.create!(first_name: "Carl", last_name: "Junior") }
  let!(:customer6) { Customer.create!(first_name: "Tony", last_name: "Bologna") }

  let!(:transaction1) { Transaction.create!(invoice_id: invoice1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "2/22", result: "success") }
  let!(:transaction2) { Transaction.create!(invoice_id: invoice2.id, credit_card_number: 4580251236515201, credit_card_expiration_date: "1/22", result: "failed") }

  it "displays an invoice's attributes" do
    visit merchant_invoice_path(merchant1, invoice1)

    expect(page).to have_content("Invoice ##{invoice1.id}")
    expect(page).to have_content("Status: In Progress")
    expect(page).to have_content("Created at: #{invoice1.created_at.strftime("%A, %B %d, %Y")}")

    expect(page).to_not have_content("Invoice ##{invoice2.id}")
    expect(page).to_not have_content("Status: completed")

    within ".customer" do
      expect(page).to have_content("Customer Name: Leanne Braun")
      expect(page).to_not have_content("Tony Bologna")
    end
  end

  it "displays a list of items on the invoice and their attributes" do
    visit merchant_invoice_path(merchant1, invoice1)

    expect(page).to have_content("Invoice Items")

    within ".invoice_items" do
      expect(page).to have_content("Item Name: Qui Esse")
      expect(page).to have_content("Quantity Sold: 5")
      expect(page).to have_content("Sold at: $13,635.00")
      expect(page).to have_content("Invoice Item Status: Packaged")

      expect(page).to have_content("Item Name: Autem Minima")
      expect(page).to have_content("Quantity Sold: 9")
      expect(page).to have_content("Sold at: $23,324.00")

      expect(page).to_not have_content("Item Name: Ea Voluptatum")
      expect(page).to_not have_content("Quantity Sold: 3")
      expect(page).to_not have_content("Sold at: $52,100.00")
    end
  end

  it "displays the total reveue of items sold on the invoice" do
    visit merchant_invoice_path(merchant1, invoice1)

    expect(page).to have_content("Total Revenue: $278,091.00")
  end

  it "can update as invoice item's status via a selector" do
    visit merchant_invoice_path(merchant1, invoice1)

    within "##{invoice_item1.id}" do
      select "#{invoice_item1.status}"
      select "shipped"
      expect(page).to have_button("Update Invoice Item Status")

      click_button "Update Invoice Item Status"
      expect(page).to have_select(selected: "shipped")
      expect(page).to_not have_select(selected: "packaged")
      expect(page).to_not have_select(selected: "pending")
    end

    expect(current_path).to eq(merchant_invoice_path(merchant1, invoice1))
  end

  it "displays the total discounted revenue for my merchant from this invoice which includes bulk discounts in the calculation", :vcr do
    visit merchant_invoice_path(merchant1, invoice1)

    expect(page).to have_content("Total Revenue: $278,091.00")
    expect(page).to have_content("Total Discounted Revenue: $139,046.00")
  end
end
