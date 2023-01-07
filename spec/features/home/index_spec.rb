require 'rails_helper'

RSpec.describe 'home index' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Billy the Guy")
    @merchant_2 = Merchant.create!(name: "Different Guy")
  end

  it 'contains links to merchant dashboards' do
    visit "/"

    expect(page).to have_content("Welcome to Little Esty Shop")
    expect(page).to have_content("Our Merchants:")
    expect(page).to have_link(@merchant_1.name)
    expect(page).to have_link(@merchant_2.name)
  end
end