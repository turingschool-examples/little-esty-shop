require 'rails_helper'

RSpec.describe 'Admin dashboard page' do

  it 'shows a header indicating that you are on the admin dashboard' do
    visit '/admin'
    expect(page).to have_content('Admin dashboard')
  end

end
