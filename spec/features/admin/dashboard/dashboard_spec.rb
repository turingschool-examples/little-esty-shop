require 'rails_helper'

RSpec.describe 'Admin dashboard' do

  it 'shows that you are on the admin dashboard' do
    visit '/admin'

    within('h1') do
      expect(page).to have_content("Admin Dashboard")
    end
  end

  it 'has a link to the admin merchants index' do
    visit '/admin'

    expect(page).to have_link("Admin Merchants Index")
  end

  it 'has a link to the admin merchants index' do
    visit '/admin'

    expect(page).to have_link("Admin Invoices Index")
  end

  it 'takes you to the admin merchants index when you click the link' do
    visit '/admin'

    click_link "Admin Merchants Index"

    expect(current_path).to eq("/admin/merchants")
  end

  it 'takes you to the admin merchants index when you click the link' do
    visit '/admin'

    click_link "Admin Invoices Index"

    expect(current_path).to eq("/admin/invoices")
  end
end
