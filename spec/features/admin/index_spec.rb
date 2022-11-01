require 'rails_helper'

RSpec.describe 'admin index page' do 
  describe 'admin header' do 
    it 'displays admin header' do 
      visit "/admin"
      
      expect(page).to have_content("Admin Dashboard")
    end
  end 
end