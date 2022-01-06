require 'rails_helper'

RSpec.describe 'The Admin Dashboard page' do
  it 'shows a header to notify the dashboard' do
    visit "/admin"

    expect(page).to have_content("Admin Dashboard")
  end

end 
