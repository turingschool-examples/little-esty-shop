require 'rails_helper'

RSpec.describe 'Admin Merchants New Page' do
  before :each do
    # enabled
    @merchant1 = Merchant.create!(name: "Tyler", status: 1)
    @merchant2 = Merchant.create!(name: "Jill", status: 1)
    # disabled
    @merchant3 = Merchant.create!(name: "Bob", status: 0)

    visit new_admin_merchant_path
  end

  it 'I can create a new merchant' do
    @merchant = Merchant.new(name: 'The pope', status: 1)

    expect(current_path).to eq(new_admin_merchant_path)
    expect(page).to have_field('Name')
    expect(page).to_not have_link('The pope')

    fill_in 'Name', with: 'The pope'
    select "#{@merchant.status}"
    click_button 'Create Merchant'

    expect(current_path).to eq(admin_merchants_path)

    expect(page).to have_link('The pope')
    expect(page).to have_button('Disable')
  end
end
