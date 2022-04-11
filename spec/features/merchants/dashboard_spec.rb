require 'rails_helper'

RSpec.describe 'merchant dashboard' do
#   As a merchant,
# When I visit my merchant dashboard (/merchant/merchant_id/dashboard)
# Then I see the name of my merchant
  before(:each) do
    @merchant = Merchant.create!(name: 'Brylan')
  end

  it 'dispalys the name of the merchant' do
    visit "/merchants/#{@merchant.id}/dashboard"
    expect(page).to have_content('Brylan')
  end

end
