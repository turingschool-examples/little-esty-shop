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

  it 'has an enable button for each merchant to modify status to enabled' do
    within(:css, "##{@merchant_1.id}") do

      expect(page).to have_content("Enable")
    end
  end

  it 'has an disable button for each merchant to modify status to disabled' do
    expect(page).to have_content("Disable")
  end

  it 'has an enable and disable button if a merchants status is nil' do
    expect(page).to have_content("Enable")
    expect(page).to have_content("Disable")
  end

end
