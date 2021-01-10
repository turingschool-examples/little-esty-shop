require 'rails_helper'

describe 'Admin Merchant Index' do
  before :each do
    @m1 = Merchant.create!(name: 'Merchant 1')
    @m2 = Merchant.create!(name: 'Merchant 2')
    @m3 = Merchant.create!(name: 'Merchant 3')
    visit admin_merchants_path
  end

  it 'should display all the merchants' do
    expect(page).to have_content(@m1.name)
    expect(page).to have_content(@m2.name)
    expect(page).to have_content(@m3.name)
  end

  it 'should have rerouting links on all merchants names to their admin show page' do
    expect(page).to have_link(@m1.name)
    click_link "#{@m1.name}"
    expect(current_path).to eq(admin_merchant_path(@m1))
  end

  it 'should have set merchants to enabled by default' do
      expect(@m1.status).to eq('enabled')
  end

  it 'should have button to disable merchants' do
    within("#merchant-#{@m1.id}") do
      expect(page).to have_button('Enable')
      expect(page).to have_button('Disable')
      click_button 'Disable'
      
      expect(@m1.status).to eq('disabled')
    end
  end
end