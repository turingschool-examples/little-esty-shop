require 'rails_helper'

RSpec.describe 'the Admin Merchant new page' do 
  before(:each) do 
    visit new_admin_merchant_path
  end

  it 'has a form that creates a new merchant' do 
    fill_in 'Name', with: 'Stevie Wonder'
    click_button 'Submit'

    expect(current_path).to eq(admin_merchants_path)
    within '#disabled' do 
      expect(page).to have_content('Stevie Wonder')
    end 
  end
end