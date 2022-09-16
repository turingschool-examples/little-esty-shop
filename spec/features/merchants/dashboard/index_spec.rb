require 'rails_helper'

RSpec.describe 'Merchant Dashboard Index' do
  before :each do
    @merchant = create(:merchant)
    visit merchant_dashboard_index_path(@merchant.id)
  end

  it 'lists the merchant name' do
    expect(page).to have_content(@merchant.name)
  end
end