require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  it 'shows the merchant name' do
    @merchant1 = create(:merchant)
    
    visit merchant_dashboard_index

    expect(page).to have_content(@merchant1.name)

  end
end
