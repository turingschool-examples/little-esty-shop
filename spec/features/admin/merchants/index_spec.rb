require 'rails_helper'

RSpec.describe 'The Admin Merchants Index' do 

  before :each do 
    @merchant1 = Merchant.create!(name: 'The Duke')
    @merchant2 = Merchant.create!(name: 'The Fluke')
    @merchant3 = Merchant.create!(name: 'The Crook')
  end 

  it 'displays the name of each merchant in the system' do 
    visit admin_merchants_path
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
  end 

  it 'displays each merchant name as a link to that merchants show page' do 
    visit admin_merchants_path
    expect(page).to have_link(@merchant1.name)
    click_link(@merchant1.name)
    expect(current_path).to eq(admin_merchant_path(@merchant1.id))
  end 
end 