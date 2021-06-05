require 'rails_helper'

RSpec.describe 'Admin Dashboard Index Page' do
  before :each do

    # visit "/admin"
    visit dashboard_index_path
  end

  it 'I see a header indicating that I am on the admin dashboard' do
    expect(page).to have_content('Admin Dashboard')
  end
end
