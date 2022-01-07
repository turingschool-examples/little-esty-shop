require 'rails_helper'

RSpec.describe "items/show", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Joe Shmoe")
    @item_1 = @merchant_1.items.create!(name: "Light Machine", description: "Revolutionary Device", unit_price: 999)
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"
  end

  it 'has item info' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content(@item_1.unit_price)
  end
end
