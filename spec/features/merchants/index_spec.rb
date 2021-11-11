require 'rails_helper'

RSpec.describe 'the Merchants index' do
  it 'displays links to each merchants dashboard' do
    merchant_1 = Merchant.create(name: 'Jimmy Pesto')

    visit "/merchants"

    expect(page).to have_content merchant_1.name

    click_on merchant_1.name

    expect(current_path).to eq "/merchants/#{merchant_1.id}/dashboard"
  end
end
