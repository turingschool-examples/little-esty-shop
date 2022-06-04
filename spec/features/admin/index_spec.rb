require 'rails_helper'

RSpec.describe "Admin Dashboard", type: :feature do
  describe "Admin User Story 1 - Admin Dashboard" do
    it "can display a header" do
      visit '/admin'

      within '#leftSide' do
      expect(page).to have_content("Admin Dashboard")

      end
    end
  end


end
