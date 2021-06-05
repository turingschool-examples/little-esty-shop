require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Roald')

    @customer_1 = Customer.create!(first_name: 'Not', last_name: 'Roald')
    @invoice_1 = @customer_1.invoices.create!(status: 1)
    @item_1 = @merchant_1.items.create!(name: 'Cactus Juice', description: 'Its the quechiest', unit_price: 100)
    @item_2 = @merchant_1.items.create!(name: 'Other Item', description: 'Not so quenchy', unit_price: 234)
    @item_3 = @merchant_1.items.create!(name: 'Not Listed', description: 'Undefined', unit_price: 0)
    @invoice_items_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 1000, status: 0)
    @invoice_items_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 2340, status: 1)

    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
  end

  it 'shows the invoice show page' do
    expect(page).to have_content(@invoice_1.id)
  end

  it 'shows invoice status' do
    expect(page).to have_content(@invoice_1.status)
  end

  it 'shows the created at in date format' do
    expect(page).to have_content(Date.today.strftime('%A, %B %d, %Y'))
  end

  it 'shows the customer first and last name' do
    expect(page).to have_content('Not')
    expect(page).to have_content('Roald')
  end

  # Merchant Invoice Show Page: Invoice Item Information

# As a merchant
# When I visit my merchant invoice show page
# Then I see all of my items on the invoice including:
# - Item name
# - The quantity of the item ordered
# - The price the Item sold for
# - The Invoice Item status
# And I do not see any information related to Items for other merchants
  it 'shows all item names' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to_not have_content(@item_3.name)
  end

  it 'shows quantity ordered' do
    expect(page).to have_content(@invoice_items_1.quantity)
    expect(page).to have_content(@invoice_items_2.quantity)
  end

  it 'shows the unit price' do
    expect(page).to have_content(@invoice_items_1.unit_price)
    expect(page).to have_content(@invoice_items_2.unit_price)
  end

  xit 'shows the status' do
    expect(page).to have_content(@invoice_items_1.status)
    expect(page).to have_content(@invoice_items_2.status)
  end

  it 'shows total revenue' do
    expect(page).to have_content(3340)
  end

#   Merchant Invoice Show Page: Update Item Status
#
# As a merchant
# When I visit my merchant invoice show page
# I see that each invoice item status is a select field
# And I see that the invoice item's current status is selected
# When I click this select field,
# Then I can select a new status for the Item,
# And next to the select field I see a button to "Update Item Status"
# When I click this button
# I am taken back to the merchant invoice show page
# And I see that my Item's status has now been updated
end
