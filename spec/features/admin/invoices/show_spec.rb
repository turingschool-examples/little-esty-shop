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

    within("#invoice_item-#{@invoice_item1.id}") do
      expect(page).to have_content("#{@item1.name}")
      expect(page).to have_content("#{@invoice_item1.quantity}")
      expect(page).to have_content("#{(@invoice_item1.unit_price/100).to_f.round(2)}")
      expect(page).to have_content("#{@invoice_item1.status}")
    end

    within("#invoice_item-#{invoice_item2.id}") do
      expect(page).to have_content("#{@item2.name}")
      expect(page).to have_content("#{invoice_item2.quantity}")
      expect(page).to have_content("#{(invoice_item2.unit_price/100).to_f.round(2)}")
      expect(page).to have_content("#{invoice_item2.status}")
    end

    within("#invoice_item-#{invoice_item3.id}") do
      expect(page).to have_content("#{@item3.name}")
      expect(page).to have_content("#{invoice_item3.quantity}")
      expect(page).to have_content("#{(invoice_item3.unit_price/100).to_f.round(2)}")
      expect(page).to have_content("#{invoice_item3.status}")
    end
  end

  # As an admin
  # When I visit an admin invoice show page
  # Then I see the total revenue that will be generated from this invoice
  it 'shows the total revenue for the invoice' do
    invoice_item2 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 50, unit_price: @item2.unit_price, status: 'shipped')
    invoice_item3 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item3.id, quantity: 25, unit_price: @item3.unit_price, status: 'shipped')

    visit admin_invoice_path("#{@invoice1.id}")

    expect(page).to have_content("Total Revenue: $#{@invoice1.total_revenue}")
    # expect(page).to have_content("Total Revenue: #{@invoice1.total_revenue.number_to_currency(price, unit: "$")}")
  end

  # As an admin
  # When I visit an admin invoice show page
  # I see the invoice status is a select field
  # And I see that the invoice's current status is selected
  # When I click this select field,
  # Then I can select a new status for the Invoice,
  # And next to the select field I see a button to "Update Invoice Status"
  # When I click this button
  # I am taken back to the admin invoice show page
  # And I see that my Invoice's status has now been updated
  # it 'has a select field for invoice status with current status selected' do
  it 'can select a new status, submit form, and see the updated status' do
    visit admin_invoice_path("#{@invoice1.id}")

    expect(page).to have_select(:status, selected: 'completed')
    expect(@invoice1.status).to_not eq('in_progress')

    page.select 'in_progress', from: :status
    click_button 'Update Invoice Status'

    expect(current_path).to eq(admin_invoice_path(@invoice1.id))

    updated_invoice = Invoice.find(@invoice1.id)

    expect(updated_invoice.status).to eq('in_progress')
    expect(page).to have_select(:status, selected: 'in_progress')
  end
end
