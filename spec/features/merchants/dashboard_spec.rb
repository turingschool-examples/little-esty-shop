require 'rails_helper'

RSpec.describe "When I visit a Merchant's dashboard", type: :feature do
  before :each do
    @joe = Merchant.create!(name: "Joe Rogan")
    @customer = Customer.create!(first_name: "Dana", last_name: "White")
    @item1 = @joe.items.create!(name: "Basketball", description: "Bouncy", unit_price: 20)
    @item2 = @joe.items.create!(name: "Baseball", description: "Not Bouncy", unit_price: 10)
    @item3 = @joe.items.create!(name: "Hockey Puck", description: "Not Bouncy", unit_price: 2)
    @inv1 = @customer.invoices.create!(status: "completed")
    InvoiceItem.create!(invoice: @inv1, item: @item1, unit_price: 20, status: "packaged")
    InvoiceItem.create!(invoice: @inv1, item: @item2, unit_price: 10, status: "packaged")
    InvoiceItem.create!(invoice: @inv1, item: @item3, unit_price: 2, status: "shipped")
  end

  scenario "I see the name of my merchant" do
    visit "/merchants/#{@joe.id}/dashboard"

    expect(page).to have_content(@joe.name)
  end

  scenario "I see a link to the merchants item and invoice indexs" do
    visit "/merchants/#{@joe.id}/dashboard"
    
    within(".navbar") do
      expect(page).to have_link("Items")
      expect(page).to have_link("Invoices")
    end
  end
# I see a section for "Items Ready to Ship"
# In that section I see a list of the names of all of my items that
# have been ordered and have not yet been shipped,
  scenario "I see items ready to ship with the corresponding 8" do
    expected_time = @inv1.created_at.strftime('%A, %b %d, %Y')
    visit "/merchants/#{@joe.id}/dashboard"

    within("#unshipped-#{@item1.name}") do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@inv1.id)
      expect(page).to have_content(expected_time)
    end
    within("#unshipped-#{@item2.name}") do
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@inv1.id)
      expect(page).to have_content(expected_time)
    end

    expect(page).to_not have_css("#unshipped-#{@item3.id}")
  end
end