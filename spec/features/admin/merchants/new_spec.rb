require 'rails_helper'

RSpec.describe 'As an admin, when I visit the new merchant page' do
  before(:each) do
    visit new_admin_merchant_path
  end

  it 'has a form to create a new merchant' do
    expect(page).to have_field(:name)
    expect(page).to have_button("Submit")
  end

  it 'when i fill in the form and click submit, it redirects me to the admin merchant index' do
    fill_in "Name", with: "CocoChanelsCrispyCroutons"
    click_button "Submit"

    expect(current_path).to eq admin_merchants_path
    expect(page).to have_content "CocoChanelsCrispyCroutons"

    click_button "Create New Merchant"
    fill_in "Name", with: "NAHHHHH"
    click_button "Submit"
    
    expect(current_path).to eq admin_merchants_path
    expect(page).to have_content "NAHHHHH"
  end
end
