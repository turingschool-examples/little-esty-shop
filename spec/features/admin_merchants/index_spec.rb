require 'rails_helper'

RSpec.describe 'Admin Merchants Index Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Tom Holland')

    visit '/admin/merchants'
  end

  it 'is on the correct page' do
    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_content('Admin Merchants')
  end

  it 'can display all merchants' do
    merchant2 =  Merchant.create!(name: 'Hol Tommand')

    expect(page).to have_content(@merchant1.name)
  end

  it 'can take user to admin merchant show page' do
    within "#merchant-#{@merchant1.id}" do
      click_link "Show"
      expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
    end
  end

  it 'can take user to edit admin merchant edit page' do
    within "#merchant-#{@merchant1.id}" do
      click_link "Edit"
      expect(current_path).to eq("/admin/merchants/#{@merchant1.id}/edit")
    end
  end
  
  it 'can take the user to create a new merchant' do 
    within "#create" do 
      click_link 'Create A New Merchant'
      expect(current_path).to eq(new_admin_merchant_path)
    end
  end 
end
