require 'rails_helper'

RSpec.describe 'merchants dashboard' do
  before :each do

  end
  it 'shows admin dashboard' do

    # As an admin,
    # When I visit the admin dashboard (/admin)
    # Then I see a header indicating that I am on the admin dashboard
    visit "/admin"

    expect(page).to have_content("Admin Dashboard")
  end

  it 'shows the admin dashboard with links' do

    # As an admin,
    # When I visit the admin dashboard (/admin)
    # Then I see a link to the admin merchants index (/admin/merchants)
    # And I see a link to the admin invoices index (/admin/invoices)
    visit "/admin"

    click_link('Merchants Index')
    expect(current_path).to eq("/admin/merchants")

    visit "/admin"

    click_link('Merchants Index')
    expect(current_path).to eq("/admin/invoices")

  end
end
