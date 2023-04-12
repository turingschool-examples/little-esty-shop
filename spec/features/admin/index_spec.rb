require 'rails_helper'

RSpec.describe '/admin', type: :feature do
  before(:each) do
    visit '/admin'
  end

  describe 'when I visit the admin dashboard page' do
    it 'I see a header indicating that I am on the admin dashboard' do
      save_and_open_page
      expect(page).to have_content('Admin Dashboard')
    end
  end
end