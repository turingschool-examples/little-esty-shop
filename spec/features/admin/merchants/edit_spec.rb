require 'rails_helper'

RSpec.describe "When I visit an Admin Merchant's edit page", type: :feature do
  before :each do
    @joe = Merchant.create!(name: "Joe Rogan")
  end

  scenario "I see fields to update the attributes" do
    visit "/admin/merchants/#{@joe.id}/edit"

    expect(page).to have_field("name")
    expect(page).to have_button("Update")
  end

  scenario ("I see prefilled fields for the merchants attributes") do
    visit "/admin/merchants/#{@joe.id}/edit"

    expect(find_field("name").value).to eq("#{@joe.name}")    
  end

  scenario ("I can update the merchant successfully") do
    visit "/admin/merchants/#{@joe.id}/edit"

    fill_in "name", with: "Trevor Suter"
    click_on "Update"

    expect(current_path).to eq("/admin/merchants/#{@joe.id}")
    expect(page).to have_content("Trevor Suter")
    expect(page).to have_content("Merchant Updated!")
    expect(page).to_not have_content("Joe Rogan")
  end
end