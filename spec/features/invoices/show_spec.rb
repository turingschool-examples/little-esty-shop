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

    @invoice_1.items.each do |item|
      expect(page).to have_content(item.name)
      #ADD QUANTITY METHOD THAT ACTUALLY COUNTS THIS<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      expect(page).to have_content(item.unit_price)
      expect(page).to have_content(item.item_status)
    end
  end

  it 'does not show other merchants items info' do
    other_merchant = Merchant.create!(name: "Other Merchant")
    other_merchant_item = other_merchant.items.create!(name: "Other Merchant Item", description: "Description of other merchants item", unit_price: 33)

    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to_not have_content("#{other_merchant_item.name}")
  end
end
