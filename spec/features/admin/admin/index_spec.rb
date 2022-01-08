require 'rails_helper'

RSpec.describe 'admin index page' do
  before(:each) do
    visit '/admin/'
  end

  it 'shows admin header' do
    within("#admin-dashboard-header") do
      expect(page).to have_content("ADMIN DASHBOARD")
    end
  end

  it 'links to merchants index' do
    within("#admin-dashboard-nav") do
      click_link("Merchants")
      expect(current_path).to eq("/admin/merchants")
    end
  end

  it 'links to invoices index' do
    within("#admin-dashboard-nav") do
      click_link("Invoices")
      expect(current_path).to eq("/admin/invoices")
    end
  end
end
