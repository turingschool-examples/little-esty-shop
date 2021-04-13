require 'rails_helper'

RSpec.describe 'admin index page', type: :feature do
  it 'has a header indicating i am on the admin dashboard' do

    visit '/admin'
    
    within("#admin_header") do
      expect(page).to have_content("Admin Dashboard")
    end
  end
  
  it 'has a link to the admin merchants index' do
    visit '/admin'
    within ("#links") do
      expect(page).to have_link("Merchants")
      click_link("Merchants")
      expect(current_path).to eq("/admin/merchants")
    end
  end
  
  it 'has a link to the admin invoices index' do
    visit '/admin'
    within ("#links") do
      expect(page).to have_link("Invoices")  
      click_link("Invoices")
      expect(current_path).to eq("/admin/invoices")
    end
  end
end