require 'rails_helper'

RSpec.describe 'Merchant Index', type: :feature do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tillman Group')
    @merchant_2 = Merchant.create!(name: 'Kozy Group')

    visit admin_merchants_path
  end

  it 'displays the name of each merchant in the system' do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
  end

  it 'each merchant has an enabled/disabled button to modify status' do
    expect(page).to have_content("Disable")
  end
end
