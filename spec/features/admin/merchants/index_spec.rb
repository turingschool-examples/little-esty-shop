require 'rails_helper'

RSpec.describe 'admin merchants index' do
  before(:each) do
    @merchant = Merchant.create!(name: "Parker")
    @merchant2 = Merchant.create!(name: "Joel")
    @merchant3 = Merchant.create!(name: "Kerri")
    @merchant4 = Merchant.create!(name: "John")
    visit '/admin/merchants'
  end

  it 'shows the name of all merchants' do
    expect(page).to have_content("Parker")
    expect(page).to have_content("Joel")
    expect(page).to have_content("Kerri")
    expect(page).to have_content("John")
  end
end
