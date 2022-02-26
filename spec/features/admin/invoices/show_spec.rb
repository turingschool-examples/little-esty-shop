require 'rails_helper'

RSpec.describe 'Invoices', type: :feature do
  before do

    @merchant1 = Merchant.create!(name: "The Tornado")
    @item1 = @merchant1.items.create!(name: "SmartPants", description: "IQ + 20", unit_price: 125)
    @item2 = @merchant1.items.create!(name: "FunPants", description: "Cha + 20", unit_price: 2000)
    @item3 = @merchant1.items.create!(name: "FitPants", description: "Con + 20", unit_price: 150)
    @customer1 = Customer.create!(first_name: "Marky", last_name: "Mark" )
    @customer2 = Customer.create!(first_name: "Larky", last_name: "Lark" )
    @customer3 = Customer.create!(first_name: "Sparky", last_name: "Spark" )
    @invoice1 = @customer1.invoices.create!(status: 1)
    @invoice2 = @customer2.invoices.create!(status: 1)
    @invoice3 = @customer2.invoices.create!(status: 1)
    @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 2, unit_price: 125, status: 1)
    @invoice_item2 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 2, unit_price: 2000, status: 2)
    @invoice_item3 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item3.id, quantity: 5, unit_price: 125, status: 0)
  end


  it "has a link to the invoice page" do
    visit "/admin/invoices/#{@invoice1.id}"

    expect(page).to have_content("Customer name: Marky Mark")
    expect(page).to have_content("Customer ID: #{@customer1.id}")
    expect(page).to have_content("Invoice Status: #{@invoice1.status}")
    expect(page).to have_content("Invoice Created: #{@invoice1.created_at.strftime("%A, %B, %d, %Y")}")
    expect(page).to have_content("Invoice ID: #{@invoice1.id}")
  end

  it "tests for sad path attributes" do #unable to sad path status and created_at as they could creat a failure.
    visit "/admin/invoices/#{@invoice1.id}"

    expect(page).to_not have_content("Customer name: Sparky Spark")
    expect(page).to_not have_content("Customer ID: #{@customer2.id}")
    expect(page).to_not have_content("Invoice ID: #{@invoice2.id}")
  end

  it " displays the items on the invoice." do
    visit "/admin/invoices/#{@invoice1.id}"
    expect(page).to have_content("Item name: #{@item1.name}")
    expect(page).to have_content("Item name: #{@item2.name}")
    expect(page).to have_content("Item status: #{@invoice_item1.status}")
    expect(page).to have_content("Item status: #{@invoice_item2.status}")
    expect(page).to have_content("Amount ordered: #{@invoice_item1.quantity}")
    expect(page).to have_content("Amount ordered: #{@invoice_item2.quantity}")
    expect(page).to have_content("Unit cost: #{@invoice_item1.unit_price}")
    expect(page).to have_content("Unit cost: #{@invoice_item2.unit_price}")
  end

  it " tests sad path." do
    visit "/admin/invoices/#{@invoice1.id}"

    expect(page).to_not have_content("Item name: #{@item3.name}")

    expect(page).to_not have_content("Item status: #{@invoice_item3.status}")

    expect(page).to_not have_content("Amount ordered: #{@invoice_item3.quantity}")

    expect(page).to have_content("Unit cost: #{@invoice_item3.unit_price}")
  end

  it " test for the total amount of the invoice." do
    visit "/admin/invoices/#{@invoice1.id}"

    expect(page).to have_content("Total amount from Marky's invoice: $2125")
  end

  it "can update status via dropdown menu's" do
    visit "/admin/invoices/#{@invoice1.id}"

    within("##{@invoice1.id}") do
      select'in progress', from: :status
      click_button("Update Invoice Status")
    end
      expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")
      expect(page).to have_content("Invoice Status: in progress")
    within("##{@invoice1.id}") do
      select'cancelled', from: :status
      click_button("Update Invoice Status")
      expect(page).to have_content("Invoice Status: cancelled")
      expect(page).to_not have_content("Invoice Status: in progress")
      expect(page).to_not have_content("Invoice Status: completed")
    end

    within("##{@invoice1.id}") do
      select'completed', from: :status
      click_button("Update Invoice Status")
      expect(page).to have_content("Invoice Status: completed")
      expect(page).to_not have_content("Invoice Status: in progress")
      expect(page).to_not have_content("Invoice Status: cancelled")
    end

    within("##{@invoice1.id}") do
      select'completed', from: :status
      click_button("Update Invoice Status")
      expect(page).to have_content("Invoice Status: completed")
      expect(page).to_not have_content("Invoice Status: in progress")
      expect(page).to_not have_content("Invoice Status: cancelled")
    end
  end
end
