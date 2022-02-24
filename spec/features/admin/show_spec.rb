require 'rails_helper'

RSpec.describe 'the admin dashboard' do
  it 'exists' do
    visit '/admin'
  end
#   As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a header indicating that I am on the admin dashboard
  it 'has an Admin Dashboard header' do
    visit '/admin'
    within 'header'
    expect(page).to have_content("Admin Dashboard")
  end
#   As an admin,
#   When I visit the admin dashboard (/admin)
#   Then I see a link to the admin merchants index (/admin/merchants)
#   And I see a link to the admin invoices index (/admin/invoices)
  it 'has links to the admin merchants index' do
    visit '/admin'
    within '.links'
    click_on("Merchants")
    expect(current_path).to eq("/admin/merchants")
  end

  it 'has links to the admin merchants index' do
    visit '/admin'
    within '.links'
    click_on("Invoices")
    expect(current_path).to eq("/admin/invoices")
  end

 end
