require 'rails_helper'

RSpec.describe 'New Merchant' do
  it 'has a form to create a new merchant and once submitted, I am taken back to the index page and I see the merchant with a status of disabled' do
    merchant1 = Merchant.create!(name: "Bobbis Bees")
    merchant2 = Merchant.create!(name: "Darnelles Daysies")
    merchant3 = Merchant.create!(name: "Alans Art")

    visit 'admin/merchants'

    expect(page).to have_link("Create a new merchant")

    click_link "Create a new merchant"

    expect(current_path).to eq('/admin/merchants/new')

    fill_in "Name", with: "Bobbies Burgers"

    click_on 'Submit'
    save_and_open_page

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content('Bobbies Burgers')
  end
end
