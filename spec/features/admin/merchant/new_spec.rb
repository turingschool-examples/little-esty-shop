require 'rails_helper'

RSpec.describe 'Admin Merchants new page' do
  it 'has a form to create a new merchant' do
    visit admin_merchants_new_path

    fill_in :name, with: "Jerry"
    click_button 'Submit'
  
    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content('Jerry')
  end
end