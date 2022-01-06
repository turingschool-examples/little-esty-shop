require 'rails_helper'

RSpec.describe 'Admin Dashboard Index page' do
  it 'shows admin header' do
    visit "/admin/dashboard"

    expect(page).to have_content("Welcome to Admin Dashboard")
  end
end
