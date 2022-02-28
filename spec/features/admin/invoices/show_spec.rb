require 'rails_helper'

RSpec.describe 'the admin invoice index' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Staples")
    @merchant_2 = Merchant.create!(name: "Dunder Miflin")

    @item_1 = @merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
    @item_2 = @merchant_1.items.create!(name: "paper", description: "construction", unit_price: 29)
    @item_3 = @merchant_2.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
    @item_4 = @merchant_2.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)

    @customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")
    @customer_2 = Customer.create!(first_name: "Person 2", last_name: "Mcperson 2")

    @invoice_1 = @customer_1.invoices.create!(status: "completed")
    @invoice_2 = @customer_1.invoices.create!(status: "cancelled")
    @invoice_3 = @customer_2.invoices.create!(status: "in progress")
    @invoice_4 = @customer_2.invoices.create!(status: "completed")

    @invoice_item_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 13, status: "shipped")
    @invoice_item_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 2, unit_price: 29, status: "packaged")
    @invoice_item_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 3, unit_price: 84, status: "pending")
    @invoice_item_4 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_4.id, quantity: 4, unit_price: 25, status: "shipped")
  end

  # describe 'github api' do
  #   it "has the repo name" do
  #     visit "/admin/invoices/#{@invoice_1.id}"
  #
  #     within ".github-info" do
  #       expect(page).to have_content("SullyBirashk/little-esty-shop")
  #     end
  #   end
  # end

  it "Invoice Information in show page" do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content("#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_1.status}")
    expect(page).to have_content("#{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("#{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("#{@customer_1.first_name}")
    expect(page).to have_content("#{@customer_1.last_name}")
  end

  it "Shows Invoice Items with item details" do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content("#{@item_1.name}")
    expect(page).to have_content("#{@item_2.name}")
    expect(page).to have_content("#{@invoice_item_1.quantity}")
    expect(page).to have_content("#{@invoice_item_2.quantity}")
    expect(page).to have_content("#{@invoice_item_1.unit_price}")
    expect(page).to have_content("#{@invoice_item_2.unit_price}")
    expect(page).to have_content("#{@invoice_item_1.status}")
    expect(page).to have_content("#{@invoice_item_2.status}")
  end

  it "Total Revenue will be shown for each item" do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content(13)
    expect(page).to have_content(58)
  end

  it "Total Revenue will be shown for each Invoice" do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content(71)
  end

  it "can change an invoice status" do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content("Invoice Status: completed")
    expect(page).to_not have_content("Invoice Status: cancelled")
    expect(page).to_not have_content("Invoice Status: in progress")

    choose("cancelled")
    click_on("Update Invoice Status")

    expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")

    expect(page).to_not have_content("Invoice Status: completed")
    expect(page).to have_content("Invoice Status: cancelled")
    expect(page).to_not have_content("Invoice Status: in progress")
  end

end
