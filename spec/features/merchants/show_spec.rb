require 'rails_helper'

RSpec.describe 'Merchant Dashboard' , type: :feature do
  before do
    @merchant_1 = create(:merchant, name: "Scott's Brewery", enabled: true)
  end

  it' displays merchant name' do
    expect(page).to have_content(@merchant_1.name)
  end
end