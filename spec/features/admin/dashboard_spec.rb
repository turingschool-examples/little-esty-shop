require 'rails_helper'

RSpec.describe "Admin Dashboard" do
    before :each do
      test_data
   end

   it 'has a header indicating that it is the admin dashboard' do
      visit '/admin'

      expect(page).to have_content("Admin Dashboard")
   end
  end