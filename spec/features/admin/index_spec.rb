require 'rails_helper'

RSpec.describe 'admin index page' do 
  describe 'admin header' do 
    it 'displays admin header' do 
      visit "/admin"
      
      expect(page).to have_content("Admin Dashboard")
    end
  end 

  describe 'admin merchant link' do 
    it 'displays links to admin merchants' do 
      visit "/admin"

      expect(page).to have_link "Admin Merchants Index"
    end
  end

  describe 'admin invoice link' do 
    it 'displays links to admin invoices' do 
      visit "/admin"

      expect(page).to have_link "Admin Invoices Index"
    end
  end
end