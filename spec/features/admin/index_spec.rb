require 'rails_helper'
describe 'Admin Dashboard' do
  
  it 'displays a header' do
    visit '/admin'

    expect(page).to have_content("Admin Dashboard")
  end
end