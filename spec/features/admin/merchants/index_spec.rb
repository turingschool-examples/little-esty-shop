require 'rails_helper'
FactoryBot.find_definitions

RSpec.describe 'admin merchants index' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
  end

  it 'lists all merchants' do
    visit admin_merchants_path

     expect(page).to have_content(@merchant_1.name)
     expect(page).to have_content(@merchant_2.name)
     expect(page).to have_content(@merchant_3.name)
     expect(page).to have_content(@merchant_4.name)
     expect(page).to have_content(@merchant_5.name)
  end
end