require 'rails_helper'

describe 'Admin Merchant Index' do
  before :each do
    @m1 = Merchant.create!(name: 'Merchant 1')
    @m2 = Merchant.create!(name: 'Merchant 2')
    @m3 = Merchant.create!(name: 'Merchant 3', status: 1)
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

#   it 'should have button to disable merchants' do
#     within("#merchant-#{@m1.id}") do
#       expect(page).to have_button('Enable')
#       expect(page).to have_button('Disable')
#       click_button 'Disable'
      
#       expect(@m1.status).to eq('disabled')
#     end
#   end

  it 'should group by enabled/disabled' do 
    expect(@m1.name).to appear_before(@m3.name)
  end

  it 'should have a link to create a new merchant' do
    expect(page).to have_link('Create Merchant')
    click_link 'Create Merchant'

    expect(current_path).to eq(new_admin_merchant_path)
    fill_in :name, with: 'Dingley Doo'
    click_button

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content('Dingley Doo')
  end
end
