require 'rails_helper'

RSpec.describe 'merchant items index' do
  before :each do
    @merchant_1 = Merchant.create!( name:"Clothing")
    @merchant_2 = Merchant.create!( name:"Food")

    @item_1       = @merchant_1.items.create!( name:"Boots",
                                        description: "Leather",
                                        unit_price: 50,
                                        enabled: true
                                      )
    @item_2       = @merchant_1.items.create!( name:"Jacket",
                                        description: "Leather",
                                        unit_price: 100,
                                        enabled: true
                                      )
    @item_3       = @merchant_1.items.create!( name:"Sweater",
                                        description: "Wool",
                                        unit_price: 25,
                                        enabled: true
                                      )
    @item_4       = @merchant_2.items.create!( name:"Apple",
                                        description: "Eat it",
                                        unit_price: 5,
                                        enabled: true
                                      )
  end

  it 'displays the name of the Merchant and no others' do
    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
  end

  xit 'lists all of the items names' do
    visit "/flower_shops/#{@mikes_flowers.id}/flowers"

    click_on "Rose"

    expect(current_path).to eq("/flowers/#{@flower2.id}")
  end
end
