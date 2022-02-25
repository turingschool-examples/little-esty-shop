require 'rails_helper'

RSpec.describe 'admin merchant index page', type: :feature do
  before do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
  end

  it 'displays all merchant names' do
    visit '/admin/merchants'
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
  end

  it 'toggles the merchant status' do
    visit '/admin/merchants'

    within("#merchant-#{@merchant1.id}") do
      click_button("enable")
    end

    expect(current_path).to eq("/admin/merchants")

    within("#merchant-#{@merchant1.id}") do
      expect(page).to have_content("status: enabled")
      click_button("disable")
    end

    expect(current_path).to eq("/admin/merchants")
    expect(@merchant1.status).to eq("disabled")

    within("#merchant-#{@merchant1.id}") do
      expect(page).to have_content("status: disabled")
    end
  end
end
