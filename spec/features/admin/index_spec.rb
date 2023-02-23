require 'rails_helper'

RSpec.describe 'Admin Dashboard:', type: :feature do 

  describe 'As an Admin,' do
    context 'when I visit the admin dashboard (/admin),' do
      it 'I see a header indicating that I am on the admin dashboard.' do
        
        visit '/admin'
        
        expect(current_path).to eq('/admin')

        within('#admin_header') do
          expect(page).to have_content("Admin Dashboard")
        end
      end
    end
  end
end