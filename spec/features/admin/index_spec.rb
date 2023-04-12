require 'rails_helper'

RSpec.describe 'Admin Index (Dashboard) Page', type: :feature do
  before(:each) do
    visit '/admin'
  end

  it 'has a header' do
    expect(page).to have_content('Admin Dashboard')
    expect(page).to have_selector('h1')
  end
end
