require 'rails_helper'

RSpec.describe "merchant dashboard" do
  it 'tests factorybot' do
    merchant = create(:merchant)
  end

  it 'can show name of merchant' do
    merchant = create(:merchant)

    visit "/merchants/#{merchant.id}/dashboard"
    expect(page).to have_content(merchant.name)
  end
end
