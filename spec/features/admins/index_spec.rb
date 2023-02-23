require 'rails_helper'

RSpec.describe "The Admin Index" do
  describe "User Story 19" do
    it "When an admin the admin dashboard (/admin), they see a header indicating that they are on the admin dashboard" do 
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end
  end
end