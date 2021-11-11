require 'rails_helper'

RSpec.describe 'Admin Merchant Index' do
  it 'has sections for enabled and disabled merchants' do
    merchant1 = Merchant.create!(name: 'Jimmy Pesto', status: 'Enabled')
    merchant1 = Merchant.create!(name: 'Linda Belcher', status: 'Disabled')
    merchant1 = Merchant.create!(name: 'Louis Belcher', status: 'Disabled')

    visit '/admin/merchants'

    expect(page).to have_content("Enabled Merchants")
    expect(page).to have_content("Disabled Merchants")

    within "Enabled" do
      expect(page).to have_content(merchant1.name)
    end

    within "Disabled" do
      expect(page). to have_content(merchant2.name)
      expect(page). to have_content(merchant3.name)
    end 
  end
end

#This needs to be synced up with Micha's user story for disabling merchants
