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

    click_link("#{@merchant_1.name}")

    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
  end

  it 'Links from index to page for creation of new merchant' do
    visit '/admin/merchants'

    expect(page).to have_link("Create New Merchant", href: "/admin/merchants/new")

    click_link("Create New Merchant")

    expect(current_path).to eq("/admin/merchants/new")
  end

  it 'Has buttons for each merchant to toggle enable/disable status' do
    visit '/admin/merchants'

    within("#merchant-#{@merchant_1.id}") do
      expect(page).to have_link("Enabled")
      click_link("Enabled")
    end

    expect(current_path).to eq("/admin/merchants")

    within("#merchant-#{@merchant_1.id}") do
      expect(page).to have_link("Disabled")
    end
  end

  it 'Sorts merchants on enabled/disabled status' do
    merchant_4 = Merchant.create!(name: "This Is A Test Value", enabled: false)
    visit '/admin/merchants'

    within("#enabled-merchants") do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      expect(page).to_not have_content(merchant_4.name)
    end

    within("#disabled-merchants") do
      expect(page).to_not have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
      expect(page).to_not have_content(@merchant_3.name)
      expect(page).to have_content(merchant_4.name)
    end      
  end
end