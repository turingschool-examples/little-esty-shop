require 'rails_helper'

RSpec.describe 'Admin Merchants Index', type: :feature do

  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
  end
  
  it 'Has all merchants' do
    visit "/admin/merchants"

    within("#merchants") do
      within("#merchant-#{@merchant_1.id}") do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to_not have_content(@merchant_2.name)
        expect(page).to_not have_content(@merchant_3.name)
      end
      within("#merchant-#{@merchant_2.id}") do
        expect(page).to_not have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_2.name)
        expect(page).to_not have_content(@merchant_3.name)
      end
      within("#merchant-#{@merchant_3.id}") do
        expect(page).to_not have_content(@merchant_1.name)
        expect(page).to_not have_content(@merchant_2.name)
        expect(page).to have_content(@merchant_3.name)
      end
    end
  end

  it 'Links from index to show page for each merchant' do
    visit '/admin/merchants'
  
    within("#merchants") do
      within("#merchant-#{@merchant_1.id}") do
        expect(page).to have_link("#{@merchant_1.name}", href: "/admin/merchants/#{@merchant_1.id}")
        expect(page).to_not have_link("#{@merchant_2.name}", href: "/admin/merchants/#{@merchant_2.id}")
        expect(page).to_not have_link("#{@merchant_3.name}", href: "/admin/merchants/#{@merchant_3.id}")
      end
    end
  end
end