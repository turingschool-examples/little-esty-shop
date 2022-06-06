require 'rails_helper'

RSpec.describe "Admin Invoice Show Page" do
  let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
  let!(:customer2) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }

  let!(:invoice1) { customer1.invoices.create!(status: 1, created_at: '2012-03-21 14:53:59') }
  let!(:invoice2) { customer2.invoices.create!(status: 2, created_at: '2012-03-23 14:53:59') }

  let!(:merchant1) { Merchant.create!(name: "Schroeder-Jerde") }
  let!(:merchant2) { Merchant.create!(name: "Klein, Rempel and Jones") }

  let!(:item1) { merchant1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti", unit_price: 75107) }
  let!(:item2) { merchant1.items.create!(name: "Autem Minima", description: "Cumque consequuntur ad", unit_price: 67076) }
  let!(:item3) { merchant2.items.create!(name: "Ea Voluptatum", description: "Sunt officia", unit_price: 68723) }

  let!(:invoice_item1) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 13635, status: "packaged") }
  let!(:invoice_item2) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 9, unit_price: 23324, status: "pending") }
  let!(:invoice_item3) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 8, unit_price: 34873, status: "packaged") }

  it "displays information related to the invoice" do
    visit admin_invoice_path(invoice1)

    expect(page).to have_content("Invoice ##{invoice1.id}")
    expect(page).to have_content("Status: In Progress")
    expect(page).to have_content("Created at: #{invoice1.created_at.strftime("%A, %B %d, %Y")}")

    expect(page).to_not have_content("Invoice ##{invoice2.id}")
    expect(page).to_not have_content("Status: Completed")

    within ".customer" do
      expect(page).to have_content("Customer Name: Leanne Braun")
      expect(page).to_not have_content("Tony Bologna")
    end

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

  it "displays the total revenue of sold items" do
    visit admin_invoice_path(invoice1)

    expect(page).to have_content("Total Revenue: $278,091.00")
  end

  it "can update and Invoice Item's status via a selector" do
    visit admin_invoice_path(invoice1)

    within "##{invoice_item1.id}" do
      select "#{invoice_item1.status}"
      select "shipped"
      expect(page).to have_button("Update Invoice Item Status")

      click_button "Update Invoice Item Status"
      expect(page).to have_select(selected: "shipped")
      expect(page).to_not have_select(selected: "packaged")
      expect(page).to_not have_select(selected: "pending")
    end

    expect(current_path).to eq(admin_invoice_path(invoice1))
  end
end
