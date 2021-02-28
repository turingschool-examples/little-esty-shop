require 'rails_helper'

RSpec.describe "When I visit an Admin Merchants Show Page" do
  before :each do
    @joe = Merchant.create!(name: "Joe Rogan")
  end

  scenario "I see the Merchant's Name" do
    visit "/admin/merchants/#{@joe.id}"

    expect(page).to have_content(@joe.name)
  end

  scenario "I see a link to update that merchants information" do
    visit "/admin/merchants/#{@joe.id}"

    expect(page).to have_link('Update Merchant', href: "/admin/merchants/#{@joe.id}/edit")
  end
end