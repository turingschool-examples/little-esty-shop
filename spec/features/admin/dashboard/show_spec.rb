require 'rails_helper'

RSpec.describe 'Admin Dashboard Show Page' do
  describe 'display' do
    it "Displays a header saying 'Admin Dashboard'" do
      visit admin_dashboard_path

      expect(page).to have_content("Admin Dashboard")
    end
  end
end