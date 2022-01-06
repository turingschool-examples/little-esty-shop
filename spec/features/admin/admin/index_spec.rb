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
end
