require 'rails_helper'

RSpec.describe "Merchant Invoices Index" do
  before(:each) do
    @merchant = Merchant.create!(name: 'Ice Cream Parlour')
    @item_1 = @merchant.items.create!(name: 'Ice Cream Scoop', description: 'scoops ice cream', unit_price: 13)
    @item_2 = @merchant.items.create!(name: 'Ice Cream Cones', description: 'holds the ice cream', unit_price: 10)
    @item_3 = @merchant.items.create!(name: 'Sprinkles', description: 'makes ice cream pretty', unit_price: 3)
    @customer = Customer.create!(first_name: 'Stuart', last_name: 'Little')
    @invoice_1 = Invoice.create!(status: 0, customer_id: "#{@customer.id}")
    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 13, status: 0)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 10, status: 0)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 3, status: 0)
    visit "/merchant/#{@merchant.id}/invoices/#{@invoice_1.id}"
  end

  it 'can see invoice id, status, created_at date, customer first and last name' do
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@customer.first_name)
    expect(page).to have_content(@customer.last_name)
  end

  it 'can see all items and their names, quantity ordered, price items sold for, and invoice item status' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@invoice_item_1.quantity)
    expect(page).to have_content(@invoice_item_1.unit_price)
    expect(page).to have_content(@invoice_item_1.status)
  end

  it 'can see total revenue from all items on invoice' do
    expect(page).to have_content(@invoice_1.invoice_items.total_revenue)
  end

  it 'can update item status on invoice' do
    # expect(page).to have_button('Update Item Status')

    within("#invoice_item-#{@invoice_item_1.id}") do
      select('packaged')
      click_on('Update Item Status')
    end
    expect(@invoice_item_1.status).to eq("packaged")
    expect(current_path).to eq("/merchant/#{@merchant.id}/invoices/#{@invoice_1.id}")
  end
end

# Merchant Invoice Show Page: Update Item Status
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
