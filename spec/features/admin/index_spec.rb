require 'rails_helper'

RSpec.describe 'as an Admin' do
  describe 'when I visit the admin dashboard' do
    it "shows me a header indicating I'm on the admin dashboard" do
      visit '/admin'

      expect(page).to have_content("Admin Dashboard")
    end
  end
end
