require 'rails_helper'

RSpec.describe 'admin index page', type: :feature do
  it 'has a header indicating i am on the admin dashboard' do

    visit '/admin'

    within("#admin_header") do
      expect(page).to have_content("Admin Dashboard")
    end
  end
end