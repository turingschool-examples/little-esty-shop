require 'rails_helper'

RSpec.describe 'Merchant show page' do
  before :each do
    @bercy = Merchant.create!(name: "Bercy Hamhands")
  end
  it "can see the name of the merchant at the merchant dashboard page" do
    visit "/merchants/#{@bercy.id}/dashboard"

    expect(page).to have_content(@bercy.name)
  end

  it "can see links to the item index page" do
    visit "/merchants/#{@bercy.id}/dashboard"

    click_link("My Items")

    expect(current_path).to eq("/items/index")
  end

  it "can see links to the invoice index page" do
    visit "/merchants/#{@bercy.id}/dashboard"

    click_link("My Invoices")

    expect(current_path).to eq("/invoices/index")
  end
end
