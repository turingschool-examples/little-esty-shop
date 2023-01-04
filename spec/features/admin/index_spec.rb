require "rails_helper"

RSpec.describe "Admin Dashboard(Index)" do
  describe "visiting admin dashboard" do
    it 'see a header indicating that user is on admin dashboard'do
      visit admin_index_path

      expect(page).to have_content("Admin Dashboard")
    end
  end
end