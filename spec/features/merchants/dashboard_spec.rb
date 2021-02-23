require 'rails_helper'

RSpec.describe "When I visit a Merchant's dashboard", type: :feature do
  before :each do
    @joe = Merchant.create!(name: "Joe Rogan")
  end

  scenario "I see the name of my merchant" do
    visit "/merchants/#{@joe.id}/dashboard"

    expect(page).to have_content(@joe.name)
  end

  scenario "I see a link to the merchants item and invoice indexs" do
    visit "/merchants/#{@joe.id}/dashboard"
    
    within(".links") do
      expect(page).to have_link("Items")
      expect(page).to have_link("Invoices")
    end
  end
end