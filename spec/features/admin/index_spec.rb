require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  it 'displays a header indicating that user is on the admin dashboard' do
    visit '/admin'
    # save_and_open_page
    within(".header") do
      expect(page).to have_content("Admin Dashboard")
    end
  end

  it 'displays link to admin merchant index' do
    visit '/admin'
    within(".link_bar") do
      expect(page).to have_link("Admin Merchants")
    end
  end

  it 'displays link to admin invoices index' do
    visit '/admin'
    within(".link_bar") do
      expect(page).to have_link("Admin Invoices")
    end
  end
end
