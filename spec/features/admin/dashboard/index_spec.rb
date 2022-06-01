require 'rails_helper'

RSpec.describe 'admin dashboard' do
  it 'has an admin header' do
  visit admin_dashboard_path

  expect(page).to have_content('Admin Dashboard')
  end
end
