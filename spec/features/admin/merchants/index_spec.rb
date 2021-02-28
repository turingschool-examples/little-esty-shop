require 'rails_helper'

RSpec.describe "When I visit the Admin Merchants index page", type: :feature do
  before :each do
    @joe = Merchant.create!(name: "Joe Rogan")
    @gary = Merchant.create!(name: "Gary Bettman")
    @roger = Merchant.create!(name: "Roger Goodell") 
  end

  scenario "I see the name of each merchant in the system" do
    visit "/admin/merchants"

    expect(page).to have_content(@joe.name)
    expect(page).to have_content(@gary.name)
    expect(page).to have_content(@roger.name)
  end
  scenario "Each merchant has a link to their show page" do
    visit "/admin/merchants"

    within("#merchant-#{@joe.id}") do
      expect(page).to have_link("#{@joe.name}", href: "/admin/merchants/#{@joe.id}")
    end
    within("#merchant-#{@gary.id}") do
      expect(page).to have_link("#{@gary.name}", href: "/admin/merchants/#{@gary.id}")
    end
    within("#merchant-#{@roger.id}") do
      expect(page).to have_link("#{@roger.name}", href: "/admin/merchants/#{@roger.id}")
    end
  end
end