require 'rails_helper'
require 'rspec'

describe "Admin dashboard", type: :feature do
  describe "when I visit the admin dashboard page" do
    it "displays a header telling me where I am" do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end
  end
end
