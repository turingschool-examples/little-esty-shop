require "rails_helper"
RSpec.describe 'The Admin Dashboard Index' do

  it 'displays a header that reads Admin Dashboard' do
    visit admin_dashboard_index_path
    expect(page).to have_content("Admin Dashboard")
  end

#   Admin Dashboard Links
#
# As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a link to the admin merchants index (/admin/merchants)
# And I see a link to the admin invoices index (/admin/invoices)

  it 'can see link to admin merchant index' do
    visit admin_dashboard_index_path
    expect(page).to have_link("Admin merchants index")
  end

  it 'can see link to admin merchant index' do
    visit admin_dashboard_index_path
    expect(page).to have_link("Admin invoices index")
  end
end
