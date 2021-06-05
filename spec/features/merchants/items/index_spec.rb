require 'rails_helper'

RSpec.describe 'merchant items index' do
  before :each do
    @merchant_1 = Merchant.create!( name:"Clothing")
    @merchant_2 = Merchant.create!( name:"Food")

    @item_1       = @merchant_1.items.create!( name:"Boots",
                                        description: "Leather",
                                        unit_price: 50,
                                        enabled: "enabled"
                                      )
    @item_2       = @merchant_1.items.create!( name:"Jacket",
                                        description: "Leather",
                                        unit_price: 100,
                                        enabled: "enabled"
                                      )
    @item_3       = @merchant_1.items.create!( name:"Sweater",
                                        description: "Wool",
                                        unit_price: 25,
                                        enabled: "disabled"
                                      )
    @item_4       = @merchant_2.items.create!( name:"Apple",
                                        description: "Eat it",
                                        unit_price: 5,
                                        enabled: "disabled"
                                      )
  end

  it 'displays the name of the Merchant and no others' do
    visit "/merchants/#{@merchant_1.id}/items"


    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
  end

  it 'lists all of the items names' do
    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_content(@item_1.name)
    expect(page).to_not have_content(@item_4.name)
  end

  it 'links to item show page' do
    visit "/merchants/#{@merchant_1.id}/items"

    click_on "#{@item_1.name}"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
  end

  it 'has a button to create a new item' do
    visit "/merchants/#{@merchant_1.id}/items"

    click_button 'New Item'

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")
  end

  it 'has button to enable or disable item' do
    visit "/merchants/#{@merchant_1.id}/items"


    within "li#id-1" do
     click_button "Disable"
   end

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    expect(page).to have_content("Disable")
  end
end
