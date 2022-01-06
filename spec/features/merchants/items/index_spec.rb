require 'rails_helper'

RSpec.describe 'merchant item index page' do
  before(:each) do
    @merchant = Merchant.create!(name: "Parker")
    @item = @merchant.items.create!(name: "Small Thing", description: "Its a thing that is small.", unit_price: 400)
    @item2 = @merchant.items.create!(name: "Large Thing", description: "Its a thing that is large.", unit_price: 800)
    visit "/merchants/#{@merchant.id}/items"
  end

  it 'shows each item name' do
    expect(page).to have_content("Small Thing")
    expect(page).to have_content("Large Thing")
  end  

end
