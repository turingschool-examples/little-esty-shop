require 'rails_helper'

RSpec.describe "Merchant invoice show" do
  it 'shows all the information relation to the invoice' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y") )
    expect(page).to have_content(@invoice_1.customer.first_name)
    expect(page).to have_content(@invoice_1.customer.last_name)
  end

  it 'shows all items and information' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    @invoice_1.invoice_items.each do |invoice_item|
      expect(page).to have_content(invoice_item.item.name)
      expect(page).to have_content(invoice_item.quantity)
      expect(page).to have_content(h.number_to_currency(invoice_item.unit_price))
      expect(page).to have_content(invoice_item.status)
    end
  end

  it 'does not show other merchants items info' do
    other_merchant = Merchant.create!(name: "Other Merchant")
    other_merchant_item = other_merchant.items.create!(name: "Other Merchant Item", description: "Description of other merchants item", unit_price: 33)

    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to_not have_content("#{other_merchant_item.name}")
  end
end
