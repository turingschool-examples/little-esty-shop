require 'rails_helper'

RSpec.describe 'admin dashboard' do
  describe 'page layout' do
    it 'has a header' do
      visit "/admin/dashboard"

      expect(page).to have_content('Admin Dashboard')
    end
  end
end
