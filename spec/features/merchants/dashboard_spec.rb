require 'rails_helper'

RSpec.describe 'Dashboard Page' do
  before :each do
    @merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    @merch2 = Merchant.create!(name: 'Molly Fine Arts')
    @merch3 = Merchant.create!(name: 'Treats and Things')
  end

  it 'shows the merchants name' do
    visit "/merchants/#{@merch1.id}/dashboard"

    within('#merchant-details') do
      expect(page).to have_content('Jolly Roger Imports')
      expect(page).to_not have_content('Molly Fine Arts')
    end

    visit "/merchants/#{@merch2.id}/dashboard"

    within('#merchant-details') do
      expect(page).to have_content('Molly Fine Arts')
      expect(page).to_not have_content('Treats and Things')
    end
  end

  it 'has a link to the merchants items index' do
    visit "/merchants/#{@merch1.id}/dashboard"

    within('#merchant-links') do
      expect(page).to have_link('My Items')
      click_on('My Items')
      expect(current_path).to eq("/merchants/#{@merch1.id}/items")
    end

  end
  
end