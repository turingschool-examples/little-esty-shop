require "rails_helper"
RSpec.describe 'The Admin Dashboard Index' do

  it 'displays a header that reads Admin Dashboard' do
    visit admin_dashboard_index_path
    expect(page).to have_content("Admin Dashboard")
  end

  it 'can see link to admin merchant index' do
    visit admin_dashboard_index_path
    expect(page).to have_link("Admin merchants index")
  end

  it 'can see link to admin merchant index' do
    visit admin_dashboard_index_path
    expect(page).to have_link("Admin invoices index")
  end
end
