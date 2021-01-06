require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'As an admin user' do
   it "when I visit the admin dashboard I see a header" do 

    visit "/admin"

    expect(page).to have_content("Admin Dashboard")
   end
    end 
  end 
