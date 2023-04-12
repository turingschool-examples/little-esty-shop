require 'rails_helper'

RSpec.describe 'Merchant Dashboard Page', type: :feature do
  before(:each) do
    visit merchant_dashboard_path(@merchant_1)
  end

  it 'has a header' do
    expect(page).to have_content('Merchant Dashboard')
  end

  it 'has the merchant name' do
    expect(page).to have_content(@merchant_1.name)
  end
end