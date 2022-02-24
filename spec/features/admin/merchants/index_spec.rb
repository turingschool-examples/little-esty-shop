require 'rails_helper'

RSpec.describe 'The Admin Merchants Index' do 

  before :each do 
    @merchant1 = Merchant.create!(name: 'The Duke')
    @merchant2 = Merchant.create!(name: 'The Fluke')
    @merchant3 = Merchant.create!(name: 'The Crook')
  end 
  it 'shows the name of each merchant in the system' do 
    visit admin_merchants_path
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
  end 
end 