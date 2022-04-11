require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do

  it 'shows admin dash header' do
    visit '/admin'

    within("#admin-header") do
      expect(page).to have_content("Admin Dashboard")
    end
  end
end