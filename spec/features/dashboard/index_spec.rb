require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before :each do 
    @merchant1 = Merchant.create!(name: 'Name')
    visit merchant_dashboard_index_path(@merchant1)
  end

  it 'shows the merchant name' do
    expect(page).to have_content(@merchant1.name)
  end
end
