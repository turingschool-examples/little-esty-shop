require 'rails_helper'
RSpec.describe 'Update an existing merchant by clicking a link on its show page' do
  before :each do
    visit "/admin/merchants/#{@merchant1.id}"
  end

  it 'can click on the link in the show page and be taken to the update form' do
    click_link("update #{@merchant1.name}")

    expect(current_path).to eq("/admin/merchants/#{@merchant1.id}/edit")
  end

  it 'can fill out a form to update a form for a specific merchant' do
    expect(page).to have_content("Costco")
    click_link("update #{@merchant1.name}")

    fill_in("Name", with: "Kostco")

    click_button("Update #{@merchant1.name}")

    expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
    expect(page).to have_content("Kostco")
    expect(page).to_not have_content("Costco")
  end

  it 'gives a flash message when you successfully update a merchant' do
    expect(page).to_not have_content("Merchant Successfully updated!")
    click_link("update #{@merchant1.name}")

    fill_in("Name", with: "Kostco")

    click_button("Update #{@merchant1.name}")

    expect(page).to have_content("Merchant Successfully updated!")
  end

  it 'gives a flash message when you do not successfully update a merchant' do
    expect(page).to_not have_content("Error: Name can't be blank")
    click_link("update #{@merchant1.name}")

    fill_in("Name", with: "")

    click_button("Update #{@merchant1.name}")

    expect(page).to have_content("Error: Name can't be blank")
  end
end