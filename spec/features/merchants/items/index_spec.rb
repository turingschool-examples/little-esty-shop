require 'rails_helper'


RSpec.describe 'the merchant item index page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Staples")
    @item_1 = @merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
    @item_2 = @merchant_1.items.create!(name: "paper", description: "construction", unit_price: 29)
    @merchant_2 = Merchant.create!(name: "Dunder Miflin")
    @item_3 = @merchant_2.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
    @item_4 = @merchant_2.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)
  end

  it "will show merchants item names" do
    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)

    expect(page).to_not have_content(@item_3.name)
    expect(page).to_not have_content(@item_4.name)
  end

  it "Can enable and disable an item" do
    visit "/items/#{@item_1.id}"

    expect(page).to have_content("Status: Disabled")

    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_button("Enable #{@item_1.name}")

    click_button("Enable #{@item_1.name}")

    expect(current_path).to eq("/items/#{@item_1.id}")

    expect(page).to have_content("Status:")

    @item_1.reload

    expect(@item_1.status).to eq("Enabled")
  end

  it "the names of merchants are links to their show page" do
    visit "/merchants/#{@merchant_1.id}/items"

    click_link("#{@item_1.name}")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")

    visit "/merchants/#{@merchant_1.id}/items"

    click_link("#{@item_2.name}")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_2.id}")
  end

  it "Has Enabled and Disabled section on index page" do
    @enabled_item = @merchant_1.items.create!(name: "pen", description: "red ink", unit_price: 5, status: "Enabled")

    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_content('Enabled Items')
    expect(page).to have_content('Disabled Items')

    within ".enabled_items" do
      expect(page).to have_content(@enabled_item.name)
    end

    within ".disabled_items" do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
    end
  end
end

describe "Top 5 Revenue" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Staples")

    @item_1 = @merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
    @item_2 = @merchant_1.items.create!(name: "paper", description: "construction", unit_price: 29)
    @item_3 = @merchant_1.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
    @item_4 = @merchant_1.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)
    @item_5 = @merchant_1.items.create!(name: "pencil", description: "24 Count", unit_price: 35)
    @item_6 = @merchant_1.items.create!(name: "fountain pen", description: "24 Count", unit_price: 45)
    @item_7 = @merchant_1.items.create!(name: "Sticky Notes", description: "24 Count", unit_price: 55)
    @item_8 = @merchant_1.items.create!(name: "Scissors", description: "2 Count", unit_price: 22)

    @customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")
    @customer_2 = Customer.create!(first_name: "Person 2", last_name: "Mcperson 2")
    @customer_3 = Customer.create!(first_name: "Person 3", last_name: "Mcperson 3")
    @customer_4 = Customer.create!(first_name: "Person 4", last_name: "Mcperson 4")
    @customer_5 = Customer.create!(first_name: "Person 5", last_name: "Mcperson 5")
    @customer_6 = Customer.create!(first_name: "Person 6", last_name: "Mcperson 6")
    @customer_7 = Customer.create!(first_name: "Person 7", last_name: "Mcperson 7")
    @customer_8 = Customer.create!(first_name: "Person 8", last_name: "Mcperson 8")

    @invoice_1 = @customer_1.invoices.create!(status: "completed", created_at: DateTime.new(2022, 2, 23))
    @invoice_2 = @customer_2.invoices.create!(status: "cancelled", created_at: DateTime.new(2022, 2, 23))
    @invoice_3 = @customer_3.invoices.create!(status: "in progress", created_at: DateTime.new(2022, 2, 23))
    @invoice_4 = @customer_4.invoices.create!(status: "completed", created_at: DateTime.new(2022, 2, 23))
    @invoice_5 = @customer_5.invoices.create!(status: "cancelled", created_at: DateTime.new(2022, 2, 23))
    @invoice_6 = @customer_6.invoices.create!(status: "in progress", created_at: DateTime.new(2022, 2, 23))
    @invoice_7 = @customer_7.invoices.create!(status: "in progress", created_at: DateTime.new(2022, 2, 23))
    @invoice_8 = @customer_8.invoices.create!(status: "in progress", created_at: DateTime.new(2022, 2, 23))

    @invoice_item_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 13, status: "shipped")
    @invoice_item_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_2.id, quantity: 2, unit_price: 29, status: "packaged") #*
    @invoice_item_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_3.id, quantity: 3, unit_price: 84, status: "pending") #*
    @invoice_item_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 4, unit_price: 25, status: "shipped") #*
    @invoice_item_5 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_5.id, quantity: 55, unit_price: 83, status: "packaged")
    @invoice_item_6 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_6.id, quantity: 65, unit_price: 92, status: "pending")
    @invoice_item_7 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_7.id, quantity: 5, unit_price: 29, status: "pending") #*
    @invoice_item_8 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_8.id, quantity: 5, unit_price: 29, status: "pending") #*

    @transcation_1 = @invoice_1.transactions.create!(credit_card_number: "4654405418249632", result: "success")
    @transcation_2 = @invoice_2.transactions.create!(credit_card_number: "4654405418249634", result: "success")
    @transcation_3 = @invoice_3.transactions.create!(credit_card_number: "4654405418249635", result: "success")
    @transcation_4 = @invoice_4.transactions.create!(credit_card_number: "4654405418249636", result: "success")
    @transcation_5 = @invoice_5.transactions.create!(credit_card_number: "4654405418249637", result: "failed")
    @transcation_6 = @invoice_6.transactions.create!(credit_card_number: "4654405418249638", result: "failed")
    @transcation_7 = @invoice_7.transactions.create!(credit_card_number: "4654405418249638", result: "success")
    @transcation_8 = @invoice_8.transactions.create!(credit_card_number: "4654405418249638", result: "success")
  end

  it "Section with Top 5 Items by revenue" do
    visit "/merchants/#{@merchant_1.id}/items"
    expect(page).to have_content('Top 5 Items by Revenue')

    within ".top_items" do
      expect(page).to have_link(@item_2.name)
      expect(page).to have_link(@item_3.name)
      expect(page).to have_link(@item_4.name)
      expect(page).to have_link(@item_7.name)
      expect(page).to have_link(@item_8.name)

      expect(@item_3.name).to appear_before(@item_7.name)
      expect(@item_7.name).to appear_before(@item_8.name)
      expect(@item_8.name).to appear_before(@item_4.name)
    end
  end

  it "Top 5 Items are links to show page" do
    visit "/merchants/#{@merchant_1.id}/items"
    within ".top_items" do
      click_link(@item_2.name)
    end
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_2.id}")
  end

  it "Each item lists its revenue" do
    visit "/merchants/#{@merchant_1.id}/items"

    within ".top_items" do
      expect(page).to have_content('58')
      expect(page).to have_content('252')
      expect(page).to have_content('100')
      expect(page).to have_content('145')
    end

  end

  it "has a link to create a new item" do
    visit "/merchants/#{@merchant_1.id}/items"

    click_link("Create New Item")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")
  end

  it "Shows Items Data" do
    invoice_9 = @customer_1.invoices.create!(status: "completed", created_at: DateTime.new(2021, 12, 18))
    invoice_10 = @customer_2.invoices.create!(status: "cancelled", created_at: DateTime.new(2021, 12, 18))
    invoice_11 = @customer_3.invoices.create!(status: "in progress", created_at: DateTime.new(2021, 12, 18))
    invoice_12 = @customer_4.invoices.create!(status: "completed", created_at: DateTime.new(2021, 12, 18))
    invoice_13 = @customer_5.invoices.create!(status: "cancelled", created_at: DateTime.new(2021, 12, 18))

    invoice_item_9 = InvoiceItem.create!(invoice_id: invoice_9.id, item_id: @item_1.id, quantity: 1, unit_price: 1, status: "shipped")
    invoice_item_10 = InvoiceItem.create!(invoice_id: invoice_10.id, item_id: @item_2.id, quantity: 1, unit_price: 1, status: "packaged") #*
    invoice_item_11 = InvoiceItem.create!(invoice_id: invoice_11.id, item_id: @item_3.id, quantity: 3, unit_price: 84, status: "pending") #*
    invoice_item_12 = InvoiceItem.create!(invoice_id: invoice_12.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: "shipped") #*
    invoice_item_13 = InvoiceItem.create!(invoice_id: invoice_13.id, item_id: @item_5.id, quantity: 1, unit_price: 1, status: "packaged")

    visit "/merchants/#{@merchant_1.id}/items"

    within ".top_items" do
      expect(page).to have_content("Top selling date for #{@item_2.name} was 2022-02-23 00:00:00 UTC")
      expect(page).to have_content("Top selling date for #{@item_3.name} was 2022-02-23 00:00:00 UTC")
      expect(page).to have_content("Top selling date for #{@item_4.name} was 2022-02-23 00:00:00 UTC")
      expect(page).to have_content("Top selling date for #{@item_7.name} was 2022-02-23 00:00:00 UTC")
      expect(page).to have_content("Top selling date for #{@item_8.name} was 2022-02-23 00:00:00 UTC")
    end
  end
end
