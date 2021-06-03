require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'header on dashboard' do
    it 'displays a header on the admin dashboard' do
      visit '/admin'

      expect(page).to have_content('Admin Dashboard')
    end
  end

  describe 'links to indices'
end
