require 'rails_helper'

RSpec.describe 'admin merchant edit page', type: :feature do
  it 'shows the merchant edit form' do
    merchant1 = Merchant.create!(name: "Abe")

    visit "/admin/merchants/#{merchant1.id}/edit"
    
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_button('Update Merchant')
  end
  
  it 'updates and redirects to admin merchant show page' do
    merchant1 = Merchant.create!(name: "Abe")
  
    visit "/admin/merchants/#{merchant1.id}/edit"

    fill_in "Name", with: "Abraham"
    click_button "Update Merchant"
    expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
  end
end