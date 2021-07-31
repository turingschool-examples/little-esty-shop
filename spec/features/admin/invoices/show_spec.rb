require 'rails_helper'

RSpec.describe 'Admin Invoice Show Page' do
  # As an admin,
  # When I visit an admin invoice show page
  # Then I see information related to that invoice including:
  # - Invoice id
  # - Invoice status
  # - Invoice created_at date in the format "Monday, July 18, 2019"
  # - Customer first and last name
  it 'shows an invoice with attributes' do
    visit admin_invoice_path("#{@invoice1.id}")

    expect(page).to have_content("#{@invoice1.id}")
    expect(page).to have_content("#{@invoice1.status}")
    expect(page).to have_content("#{@invoice1.created_at.strftime('%A, %b %d, %Y')}")
    expect(page).to have_content("#{@customer1.first_name}")
    expect(page).to have_content("#{@customer1.last_name}")

    expect(page).to_not have_content("#{@invoice8.id}")
    expect(page).to_not have_content("#{@invoice8.status}")
    expect(page).to_not have_content("#{@customer2.first_name}")
    expect(page).to_not have_content("#{@customer2.last_name}")
  end

  # As an admin
  # When I visit an admin invoice show page
  # Then I see all of the items on the invoice including:
  # - Item name
  # - The quantity of the item ordered
  # - The price the Item sold for
  # - The Invoice Item status
  it 'shows all items on the invoice' do
    invoice_item2 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 50, unit_price: @item2.unit_price, status: 'shipped')
    invoice_item3 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item3.id, quantity: 25, unit_price: @item3.unit_price, status: 'shipped')

    visit admin_invoice_path("#{@invoice1.id}")

    within("div#invoice_item1") do
      expect(page).to have_content("#{@item1.name}")
      expect(page).to have_content("#{@invoice_item1.quantity}")
      expect(page).to have_content("#{@invoice_item1.unit_price}")
      expect(page).to have_content("#{@invoice_item1.status}")
    end

    within("div#invoice_item2") do
      expect(page).to have_content("#{@item2.name}")
      expect(page).to have_content("#{invoice_item2.quantity}")
      expect(page).to have_content("#{invoice_item2.unit_price}")
      expect(page).to have_content("#{invoice_item2.status}")
    end

    within("div#invoice_item3") do
      expect(page).to have_content("#{@item3.name}")
      expect(page).to have_content("#{invoice_item3.quantity}")
      expect(page).to have_content("#{invoice_item3.unit_price}")
      expect(page).to have_content("#{invoice_item3.status}")
    end
  end
end
