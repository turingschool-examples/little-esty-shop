require 'rails_helper'

RSpec.describe "admin dashboard" do
    it 'has an admin dashboard header ' do

      visit("/admin")

      expect(page).to have_content("Admin Dashboard")
    end
  end
