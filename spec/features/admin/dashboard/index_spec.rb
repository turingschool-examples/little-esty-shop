require 'rails_helper'

describe 'Admin Dashboard Index Page' do
  it 'should display a header indicating the admin dashboard' do
    visit admin_dashboard_index_path

    expect(page).to have_content('Admin Dashboard')
  end
end