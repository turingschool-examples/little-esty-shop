require 'rails_helper'

RSpec.describe 'admin merchants index page', type: :feature do
  it 'displays the names of each merchant as a link' do 
    merchant1 = Merchant.create!(name: "Abe")
    merchant2 = Merchant.create!(name: "Bel")
    merchant3 = Merchant.create!(name: "Cat")
    
    visit '/admin/merchants'
    
    within "#merchant-#{merchant1.id}" do
      expect(page).to have_link(merchant1.name)
    end
    within "#merchant-#{merchant2.id}" do
      expect(page).to have_link(merchant2.name)
    end
    within "#merchant-#{merchant3.id}" do
      expect(page).to have_link(merchant3.name)
    end
  end
  
  it 'displays each merchants status' do
    merchant1 = Merchant.create!(name: "Abe")
    merchant2 = Merchant.create!(name: "Bel")
    merchant3 = Merchant.create!(name: "Cat")
    
    visit '/admin/merchants'
    
    within "#merchant-#{merchant1.id}" do
      expect(page).to have_content(merchant1.status)
    end
    within "#merchant-#{merchant2.id}" do
      expect(page).to have_content(merchant2.status)
    end
    within "#merchant-#{merchant3.id}" do
      expect(page).to have_content(merchant3.status)
    end
  end

  it 'has a button to disable the merchant if it is enabled, vise versa' do
    merchant1 = Merchant.create!(name: "Abe")
    merchant2 = Merchant.create!(name: "Bel", status: :enabled)
    merchant3 = Merchant.create!(name: "Cat", status: :disabled)
    
    visit '/admin/merchants'
    
    within "#merchant-#{merchant1.id}" do
      expect(page).to have_button("Disable")
      click_button "Disable"
      expect(current_path).to eq('/admin/merchants')
    end
    
    within "#merchant-#{merchant2.id}" do
      expect(page).to have_button("Disable")
      click_button "Disable"
      expect(current_path).to eq('/admin/merchants')
    end
    
    within "#merchant-#{merchant3.id}" do
      expect(page).to have_button("Enable")
      click_button "Enable"
      expect(current_path).to eq('/admin/merchants')
    end

    expect(merchant1.status).to eq("disabled")
    expect(merchant2.status).to eq("disabled")
    expect(merchant3.status).to eq("enabled")
  end

  it 'has a section for enabled merchants and a section for disabled merchants' do
    merchant1 = Merchant.create!(name: "Abe")
    merchant2 = Merchant.create!(name: "Bel", status: :enabled)
    merchant3 = Merchant.create!(name: "Cat", status: :disabled)

    expect(page).to have_content("Enabled Merchants")
    expect(page).to have_content("Disabled Merchants")

    within("#enabled_merchants") do
      expect(page).to have_content(merchant1.name)
      expect(page).to have_content(merchant2.name)
    end

    within("#disabled_merchants") do
      expect(page).to have_content(merchant3.name)
    end
  end
end