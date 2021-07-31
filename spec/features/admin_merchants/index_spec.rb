require 'rails_helper'

RSpec.describe 'Admin Merchants Index Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Tom Holland', status: 0)
    @merchant2 = Merchant.create!(name: 'Beta', status: 1)
    @merchant3 = Merchant.create!(name: 'Charlie', status: 0)
    @merchant4 = Merchant.create!(name: 'Delta', status: 1)
    @merchant5 = Merchant.create!(name: 'Exodus', status: 0)
    @merchant6 = Merchant.create!(name: 'Fenta', status: 1)

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

  it 'can display enabled merchants section' do 
    within "#enabled" do 
      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant3.name)
      expect(page).to have_content(@merchant5.name)
    end
  end

  it 'can display disabled merchants section' do 
    within "#disabled" do 
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_content(@merchant4.name)
      expect(page).to have_content(@merchant6.name)
    end
  end

end
