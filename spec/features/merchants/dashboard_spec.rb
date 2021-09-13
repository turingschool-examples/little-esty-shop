require 'rails_helper'

describe 'merchant dashboard page' do
  before(:each) do
    @merch_1 = create(:merchant)

    visit "/merchants/#{@merch_1.id}/dashboard"
  end
  
  it 'shows the name of the merchant' do
    expect(page).to have_content(@merch_1.name)
  end
end