require 'rails_helper'

RSpec.describe 'admin index page' do
  it 'has a header indicating the user is on the admin dashboard' do
    visit "/admin"

    expect(page).to have_content('Admin Dashboard Page')
  end

  it 'has links to admin merchants and admin invoices indexes' do
    visit '/admin'

    click_on("Admin Merchants")
    expect(current_path).to eq("/admin/merchants")

    visit '/admin'

    click_on("Admin Invoices")
    expect(current_path).to eq("/admin/invoices")    
  end
end
