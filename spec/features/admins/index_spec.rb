require 'rails_helper'

RSpec.describe 'admins dashboard' do
  it 'shows header indicating that I am on the admin dashboard' do
    # visit admin_index_path
    visit '/admin'

    expect(page).to have_content("Welcome to the Admin Dashboard")
  end
end