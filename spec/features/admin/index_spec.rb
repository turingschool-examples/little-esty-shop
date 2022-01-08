require 'rails_helper'

RSpec.describe 'Admin Dashboard Index' do
  describe 'view' do

    it 'I see a header indicating that I am on the admin dashboard' do
      visit "/admin"

      expect(page).to have_content("Welcome to the admin dashboard")
    end
  end
end
