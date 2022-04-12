require 'rails_helper'

RSpec.describe 'Admin Merchants Index', type: :feature do

  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
  end
  
  it 'Has all merchants' do
    visit '/admin/merchants'

    within("#merchants") do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
    end
  end
end