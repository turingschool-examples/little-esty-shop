require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  describe "As an admin" do
    describe "I visit the admin dashboard" do
      it "I see a header indicating that I am on the admin dashboard" do
        visit admins_path

        expect(page).to have_content("Admin Dashboard")
      end
    end
  end
end