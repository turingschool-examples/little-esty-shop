require 'rails_helper'

RSpec.describe 'Admin Merchant Index' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Larry's Lucky Ladles")
    @merchant_2 = Merchant.create!(name: "Bob's Burgers")
  end

  it 'displays the name of all merchants' do
    visit '/admin/merchants'
    
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_1.name)
  end
end
