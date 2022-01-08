require 'rails_helper'

RSpec.describe 'admin merchants index' do
  before(:each) do
    @merchant = FactoryBot.create(:merchant, status: "disabled")
    @merchant1 = FactoryBot.create(:merchant, status: "enabled")
    @merchant2 = FactoryBot.create(:merchant)
    @merchant3 = FactoryBot.create(:merchant)
    visit '/admin/merchants'
  end

  it 'shows the name of all merchants' do
    visit '/admin/merchants'
    expect(page).to have_content(@merchant.name)
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
  end

  it 'has can enable a merchant' do
    expect(@merchant.status).to eq("disabled")
    within("#admin-merchant-#{@merchant.id}") do
      click_button("Enable")
      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_button("Disable")
    end
  end

  it 'can disable a merchant' do
    expect(@merchant1.status).to eq("enabled")
    within("#admin-merchant-#{@merchant1.id}") do
      click_button("Disable")
      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_button("Enable")
    end
  end
end
