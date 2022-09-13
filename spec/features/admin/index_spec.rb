require 'rails_helper'

RSpec.describe 'Admin Dashboard Page', type: :feature do
    describe 'Header' do
        it 'indicates admin is on the dashboard' do
            visit("/admin")
            expect(page).to have_content("Admin Dashboard")
        end
        
    end
end