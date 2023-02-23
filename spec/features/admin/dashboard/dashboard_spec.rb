require 'rails_helper'

describe 'dashboard' do
  describe '/admin' do
    
    it 'should have a header \'admin dashboard\'' do
      visit '/admin'
      within('div#header') do
        expect(page).to have_content("Admin Dashboard")
      end
    end

  end
end