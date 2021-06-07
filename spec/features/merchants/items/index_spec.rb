require 'rails_helper'

RSpec.describe 'Merchant Items Index' do

  before :each do
    @merchant_1 = Merchant.create!(name: "Regina's Ragin' Ragdolls")
    @merchant_2 = Merchant.create!(name: "Mark's Money Makin' Markers")
    @merchant_3 = Merchant.create!(name: "Caleb's California Catapults")

    @item_1 = @merchant_1.items.create!(name: "Twinkies", description: "Yummy", unit_price: 400)
    @item_2 = @merchant_1.items.create!(name: "Applesauce", description: "Yummy", unit_price: 400)
    @item_3 = @merchant_1.items.create!(name: "Milk", description: "Yummy", unit_price: 400)
    @item_4 = @merchant_1.items.create!(name: "Bread", description: "Yummy", unit_price: 400)
    @item_5 = @merchant_1.items.create!(name: "Ice Cream", description: "Yummy", unit_price: 400)
    @item_6 = @merchant_1.items.create!(name: "Waffles", description: "Yummy", unit_price: 400)

    @customer_1 = Customer.create!(first_name: "Regina", last_name: "Last Name")
    @customer_2 = Customer.create!(first_name: "Jennifer", last_name: "Last Name")
    @customer_3 = Customer.create!(first_name: "Mark", last_name: "Last Name")
    @customer_4 = Customer.create!(first_name: "Caleb", last_name: "Last Name")
    @customer_5 = Customer.create!(first_name: "Richard", last_name: "Last Name")
    @customer_6 = Customer.create!(first_name: "Zach", last_name: "Last Name")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 0)
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 1)
    @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: 1)
    @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: 1)
    @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: 1)
    @invoice_6 = Invoice.create!(customer_id: @customer_6.id, status: 1)


    InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 5, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 2, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 3, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 4, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_5.id, quantity: 4, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_6.id, quantity: 2, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: 1500, status: 0)
    InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_6.id, quantity: 2, unit_price: 1500, status: 0)

    Transaction.create!(invoice_id: @invoice_2.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_3.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_4.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_5.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    Transaction.create!(invoice_id: @invoice_6.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
  end

  #   Merchant Items Index Page
  #
  # As a merchant,
  # When I visit my merchant items index page ("merchants/merchant_id/items")
  # I see a list of the names of all of my items
  # And I do not see items for any other merchant
  it 'Can visit a merchant index page' do
    merchant = Merchant.create!(name: 'Schroeder-Jerde')
    merchant.items.create!(name: 'Item Qui Esse', description: 'description', unit_price: 7510)
    visit "/merchants/#{merchant.id}/items"
    expect(current_path).to eq("/merchants/#{merchant.id}/items")
    expect(page).to have_content('Schroeder-Jerde')
    expect(page).to have_content('Item Qui Esse')
  end

  #   Merchant Item Disable/Enable
  #
  # As a merchant
  # When I visit my items index page
  # Next to each item name I see a button to disable or enable that item.
  # When I click this button
  # Then I am redirected back to the items index
  # And I see that the items status has changed
  it 'can update status of an item' do
    @merchant = Merchant.create!(name: 'Schroeder-Jerde')
    @item_10 = @merchant.items.create!(name: 'Item Qui Esse', description: 'description', unit_price: 7510, status: "enable")
    visit "/merchants/#{@merchant.id}/items"
    # binding.pry
    find_button("Disable").click


    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    expect(page).to have_button("Enable")

    @item_10 = Item.find(@item_10.id)

    expect(@item_10.status).to eq("disable")
  end

  #   Merchant Items Grouped by Status
  #
  # As a merchant,
  # When I visit my merchant items index page
  # Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
  # And I see that each Item is listed in the appropriate section
  it 'Items are separated into enable and disable' do
    @merchant = Merchant.create!(name: 'Schroeder-Jerde')
    @item_10 = @merchant.items.create!(name: 'Item Qui Esse', description: 'description', unit_price: 7510, status: "enable")
    visit "/merchants/#{@merchant.id}/items"

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    expect(page).to have_content("Disabled Items")
    expect(page).to have_content("Enabled Items")
  end

  #   Merchant Item Create
  #
  # As a merchant
  # When I visit my items index page
  # I see a link to create a new item.
  # When I click on the link,
  # I am taken to a form that allows me to add item information.
  # When I fill out the form I click ‘Submit’
  # Then I am taken back to the items index page
  # And I see the item I just created displayed in the list of items.
  # And I see my item was created with a default status of disabled.
  it 'Can add a new item for merchant' do
    @merchant = Merchant.create!(name: 'Schroeder-Jerde')
    @item_10 = @merchant.items.create!(name: 'Item Qui Esse', description: 'description', unit_price: 7510, status: "enable")
    visit "/merchants/#{@merchant.id}/items"

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")

    expect(page).to have_button("Add a New Item")
    click_button("Add a New Item")

    expect(current_path).to eq("/merchants/#{@merchant.id}/items/new")
    fill_in( 'Name', with: "New Item Name")
    fill_in( 'Description', with: "Made from 100% cotton.")
    fill_in( 'Unit price', with: 75608)
    click_on("Submit")

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    expect(page).to have_content("New Item Name")
  end

  #   Merchant Items Index: 5 most popular items
  #
  # As a merchant
  # When I visit my items index page
  # Then I see the names of the top 5 most popular items ranked by total revenue generated
  # And I see that each item name links to my merchant item show page for that item
  # And I see the total revenue generated next to each item name
  #
  # Notes on Revenue Calculation:
  # - Only invoices with at least one successful transaction should count towards revenue
  # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
  # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

  it 'shows top 5 times for merchant' do
    visit "/merchants/#{@merchant_1.id}/items"
    # save_and_open_page
    expect(page).to have_content("1. Ice Cream 120.0")
    expect(page).to have_content("2. Applesauce 90.0")
    expect(page).to have_content("3. Waffles 60.0")
    expect(page).to have_content("4. Bread 45.0")
    expect(page).to have_content("5. Milk 30.0")
  end

  #   Merchant Items Index: Top Item's Best Day
  #
  # When I visit the items index page
  # Then next to each of the 5 most popular items I see the date with the most sales for each item.
  # And I see a label “Top selling date for <item name> was <date with most sales>"
  #
  # Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
  it 'shows top day for merchant' do
    visit "/merchants/#{@merchant_1.id}/items"
    expect(page).to have_content("Top selling date for Ice Cream was 06/07/2021")
    expect(page).to have_content("Top selling date for Applesauce was 06/07/2021")
    expect(page).to have_content("Top selling date for Waffles was 06/07/2021")
    expect(page).to have_content("Top selling date for Bread was 06/07/2021")
    expect(page).to have_content("Top selling date for Bread was 06/07/2021")
  end

end
