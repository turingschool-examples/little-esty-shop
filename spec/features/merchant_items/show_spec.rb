require 'rails_helper'

RSpec.describe 'Merchant Items Show' do
  before :each do
    @merchant = Merchant.create!(name: "Angela's Shop")
    @item_1 = @merchant.items.create!(name: "Jade Rabbit", description: "25mmx25mm hand carved jade rabbit", unit_price: 2500)
  end

  it 'displays its attributes' do

    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}"

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content("$25.00")
  end
end
