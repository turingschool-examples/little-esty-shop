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
end