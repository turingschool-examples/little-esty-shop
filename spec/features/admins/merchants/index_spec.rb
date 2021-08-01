require 'rails_helper'

RSpec.describe 'Merchant Index', type: :feature do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tillman Group', status: false)
    @merchant_2 = Merchant.create!(name: 'Kozy Group', status:true)

    visit admin_merchants_path
  end

  it 'displays the name of each merchant in the system' do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
  end

  it 'has an enable button for each merchant to modify status to enabled' do
    within(:css, "##{@merchant_1.id}") do

      expect(page).to have_button("Enable")
    end
  end

  it 'has an disable button for each merchant to modify status to disabled' do #within block still finding duplicate buttons if status is the same
    within(:css, "##{@merchant_1.id}") do

      click_button 'Enable'

      expect(page).to have_button("Disable")
    end
  end

  it 'can group merchants by status' do #wrap both each blocks in a div to be able to test which merchants are appearing in each seciton

    expect(@merchant_1.name).to_not appear_before('Disabled Merchants')
    expect(@merchant_2.name).to appear_before('Disabled Merchants')
  end
end
