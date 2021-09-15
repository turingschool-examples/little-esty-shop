require 'rails_helper'

RSpec.describe 'Create a new merchant' do
  it ' has a form to create a new merchant' do
    visit "/admin/merchants/new"
    fill_in :name, with: 'Buffalo Bill'
    click_on "Submit"
    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content('Buffalo Bill')
    expect(page).to have_content('New Merchant has been created')
  end

  it 'has a flash message if merchant cannot be created' do
    visit "/admin/merchants/new"
    click_on "Submit"
    expect(current_path).to eq("/admin/merchants/new")
    expect(page).to have_content("Error: Name can't be blank")
  end
end
