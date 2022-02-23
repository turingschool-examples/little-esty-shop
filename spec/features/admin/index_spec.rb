require 'rails_helper'

RSpec.describe 'Admin Index' do
  it 'has a header that lets the user know they are on the admin dashboard' do

    visit '/admin'

    expect(page).to have_content('Admin Dashboard')
  end
end
