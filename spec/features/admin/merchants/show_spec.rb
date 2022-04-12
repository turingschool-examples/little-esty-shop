require 'rails_helper'

RSpec.describe 'Admin Merchant Show', type: :feature do

  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end

  it 'Shows the name attribute for the selected merchant' do
    visit '/admin/merchants/:id'

    within("#merchant-#{@merchant_1.id}") do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
    end 
  end

end