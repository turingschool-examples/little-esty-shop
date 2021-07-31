require 'rails_helper'

RSpec.describe 'Admin New Merchant Page' do 
  before :each do 
    visit new_admin_merchant_path
  end

  it 'is on the right page' do 
    expect(current_path).to eq(new_admin_merchant_path)
    expect(page).to have_content('New Admin Merchant')
  end

  it 'has a create new merchant form' do 
    expect(page).to have_field('Name')
  end

  it 'can create a new merchant' do 
    fill_in('Name', with: 'Tom Holland')
    click_button 'Create' 
    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content('Tom Holland')
    expect(page).to have_content("Tom Holland successfully Created.")
  end  

  it 'can throw error when field isnt filled' do 
    click_button 'Create' 
    expect(current_path).to eq(new_admin_merchant_path)
   
    expect(page).to have_content("Don't Be Silly! Please Fill Out The Required Fields!")
  end  

end