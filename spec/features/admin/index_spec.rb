require 'rails_helper'

RSpec.describe 'admin index page' do
  describe 'header' do
    it 'indicates we are on admin dashboard with header' do
      visit admin_index_path

      within('header') do
        expect(page).to have_content('Admin Dashboard')
      end
    end
  end
end
