require 'rails_helper'

RSpec.describe 'Admin' do
  it 'it shows admin dashboard' do
    # Admin Dashboard

    # As an admin,
    # When I visit the admin dashboard (/admin)
    # Then I see a header indicating that I am on the admin dashboard
    visit '/admin'

    expect(page).to have_content('Admin Dashboard')
  end

  it 'has links' do
    # Admin Dashboard Links
    # As an admin,
    # When I visit the admin dashboard (/admin)
    # Then I see a link to the admin merchants index (/admin/merchants)
    # And I see a link to the admin invoices index (/admin/invoices)
    visit '/admin'
    expect(page).to have_link('Merchants')
    click_link 'Merchants'
    expect(current_path).to eq('/admin/merchants')

    visit '/admin'
    expect(page).to have_link('Invoices')
    click_link 'Invoices'
    expect(current_path).to eq('/admin/invoices')
  end
end
