require 'rails_helper'

RSpec.describe 'Admin Dashboard Index Page' do
  before :each do

    # visit "/admin"
    visit dashboard_index_path
  end

  it 'I see a header indicating that I am on the admin dashboard' do
    expect(page).to have_content('Admin Dashboard')
  end

  it "Then I see a link to the admin merchants & invoices index page" do
    expect(page).to have_link('Admin Merchant Index Page', href: admin_merchants_path)
    expect(page).to have_link('Admin Invoice Index Page', href: admin_invoices_path)
  end
end
