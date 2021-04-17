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
end