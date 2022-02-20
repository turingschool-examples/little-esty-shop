require 'rails_helper'

RSpec.describe 'Updates an existing merchant:', type: :feature do

  it 'updates a merchants name' do

    merchant = create(:merchant, status: "disabled")

    visit "/admin/merchants/#{merchant.id}"

    click_link("Update Merchant")

    expect(current_path).to eq("/admin/merchants/#{merchant.id}/edit")

    fill_in("Name", with: "Bliffert's Bootleg Beanie Babies")

    click_button("Update Merchant")
    expect(current_path).to eq("/admin/merchants/#{merchant.id}")

    expect(page).to have_content("Bliffert's Bootleg Beanie Babies")
    expect(page).to have_content("status: disabled")
  end

  it 'updates a merchants status' do

    merchant = create(:merchant, status: "disabled")
    name = merchant.name

    visit "/admin/merchants/#{merchant.id}"

    click_link("Update Merchant")

    expect(current_path).to eq("/admin/merchants/#{merchant.id}/edit")

    fill_in("Status", with: "enabled")

    click_button("Update Merchant")
    expect(current_path).to eq("/admin/merchants/#{merchant.id}")

    expect(page).to have_content(name)
    expect(page).to have_content("status: enabled")
  end

  it 'updates a merchants name and status' do

    merchant = create(:merchant, status: "disabled")

    visit "/admin/merchants/#{merchant.id}"

    click_link("Update Merchant")

    expect(current_path).to eq("/admin/merchants/#{merchant.id}/edit")

    fill_in("Name", with: "Jerry Jipper's Jingle Jangles")
    fill_in("Status", with: "enabled")

    click_button("Update Merchant")
    expect(current_path).to eq("/admin/merchants/#{merchant.id}")

    expect(page).to have_content("Jerry Jipper's Jingle Jangles")
    expect(page).to have_content("status: enabled")
  end
  
end
