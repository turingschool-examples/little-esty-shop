require 'rails_helper'

RSpec.describe 'admin dashboard' do
#   As an admin,
#     When I visit the admin dashboard (/admin)
# Then I see a header indicating that I am on the admin dashboard
  describe 'US1' do
    describe 'admin index page' do
      it 'has an admin dashboard header' do
        visit "/admin"
        expect(page).to have_content("Admin Dashboard")
        expect(page).to_not have_content("Merchant Dashboard")
      end
    end
  end

  describe 'US2' do
    describe 'admin index page' do
      it 'has a link to the admin merchants index' do
        visit "/admin"

        click_link "Admin Merchants Index"

        expect(current_path).to eq("/admin/merchants")
      end

      it 'has a link to the admin invoices index'
    end
  end


end
