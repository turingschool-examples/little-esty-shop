require 'rails_helper'

RSpec.describe 'merchant invoices page', type: :feature do
  before :each do
    @merch1 = Merchant.create!(name: 'Floopy Fopperations')
    @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
    @item2 = @merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
    @item3 = @merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)

    @merch2 = Merchant.create!(name: 'Goopy Gopperations')
    @item4 = @merch2.items.create!(name: 'Goopy Original', description: 'the bester', unit_price: 1450)
    @item5 = @merch2.items.create!(name: 'Goopy Updated', description: 'the even better', unit_price: 1950)

    @cust1 = Customer.create!(first_name: "Mark", last_name: "Ruffalo")

    @inv1 = @cust1.invoices.create!(status: "in progress")
    @inv2 = @cust1.invoices.create!(status: "completed")

    InvoiceItem.create!(item_id: "#{@item1.id}", invoice_id: "#{@inv1.id}")
    InvoiceItem.create!(item_id: "#{@item4.id}", invoice_id: "#{@inv2.id}")
  end

  it 'can see all the invoices(and id) that have at least one of my merchants items' do
  # As a merchant,
  # When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
  # Then I see all of the invoices that include at least one of my merchant's items
  # And for each invoice I see its id

  visit "/merchants/#{@merch1.id}/invoices"

  expect(page).to have_content("Invoice #{@inv1.id}")
  expect(page).to have_content("Status: #{@inv1.status}")
  expect(page).to_not have_content("Invoice #{@inv2.id}")


  end

  it 'has a link on each id to the merchant invoice show page' do
  # And each id links to the merchant invoice show page
    visit "/merchants/#{@merch1.id}/invoices"

    click_link "#{@inv1.id}"

    expect(current_path).to eq("/merchants/#{@merch1.id}/invoices/#{@inv1.id}")
  end
end
