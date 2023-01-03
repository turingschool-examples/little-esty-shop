require 'rails_helper'

RSpec.describe 'admin dashboard' do
  it 'has a header for the page name' do
    visit '/admin'
    expect(page).to have_content("Admin Dashboard")

  end





end