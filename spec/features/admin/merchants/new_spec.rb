require 'rails_helper'

RSpec.describe "create admin/merchants" do
  it 'has a create merchant link' do
    visit '/admin/merchants'
    expect(page).to have_link("Create New Merchant")
    click_on "Create New Merchant"
    expect(current_path).to eq("/admin/merchants/new")
  end

  it 'can create a new merchant' do
    visit "/admin/merchants/new"

    fill_in :name, with: "Store 1"
    click_on "Save"
    
    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("Store 1")
  end
end
