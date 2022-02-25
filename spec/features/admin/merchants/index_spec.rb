require 'rails_helper'

RSpec.describe 'The Admin Merchants Index' do 

  before :each do 
    @merchant1 = Merchant.create!(name: 'The Duke')
    @merchant2 = Merchant.create!(name: 'The Fluke')
    @merchant3 = Merchant.create!(name: 'The Crook')
  end 

  it 'displays the name of each merchant in the system' do 
    visit admin_merchants_path

    within '#the-duke' do 
      expect(page).to have_content(@merchant1.name)
    end 
    within '#the-fluke' do 
      expect(page).to have_content(@merchant2.name)
    end 
    within '#the-crook' do 
      expect(page).to have_content(@merchant3.name)
    end 
  end 

  it 'displays each merchant name as a link to that merchants show page' do 
    visit admin_merchants_path
    expect(page).to have_link(@merchant1.name)
    click_link(@merchant1.name)
    expect(current_path).to eq(admin_merchant_path(@merchant1.id))
  end 

  it 'displays a button an admin can use to enable or disable a merchants status' do 
    visit admin_merchants_path
    within '#the-duke' do
      expect(page).to have_button("disable merchant")
      expect(@merchant1.status).to eq("enabled")
      expect(page).to have_no_button("enable merchant")  
      click_button("disable merchant")
      expect(current_path).to eq(admin_merchants_path)
      @merchant1.reload
      expect(page).to have_button("enable merchant")
    end
    
  end 
end 