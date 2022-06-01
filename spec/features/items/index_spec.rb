require 'rails_helper'

RSpec.describe 'Item Index' do 
  it 'lists names of all items' do 
    merchant_1 = Merchant.create(name: "Ray's Handmade Jewelry")
    item_1 = merchant_1.items.create!(name: "Dangly Earings" , description: 'They tickle your neck.', unit_price: 1500 )
    item_2 = merchant_1.items.create!(name: "Gold Ring" , description: 'There are many rings of power...' , unit_price: 4999 )
    item_3 = merchant_1.items.create!(name: "Silver Ring" , description: 'A simple, classic, and versatile piece' , unit_price: 2999 )
    
    merchant_2 = Merchant.create(name: "Antique's by Annie")
    item_4 = merchant_2.items.create!(name: "1920's Driving Gloves" , description: 'Leather' , unit_price: 2999 )
   
    visit merchant_items_path(merchant_1.id)

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(item_3.name)

    expect(page).to_not have_content(item_4.name)
  end

  it 'has link to all of the merchants items' do  
    merchant_1 = Merchant.create(name: "Ray's Handmade Jewelry")
    item_1 = merchant_1.items.create!(name: "Dangly Earings" , description: 'They tickle your neck.', unit_price: 1500 )
    item_2 = merchant_1.items.create!(name: "Gold Ring" , description: 'There are many rings of power...' , unit_price: 4999 )
    item_3 = merchant_1.items.create!(name: "Silver Ring" , description: 'A simple, classic, and versatile piece' , unit_price: 2999 )
    
    merchant_2 = Merchant.create(name: "Antique's by Annie")
    item_4 = merchant_2.items.create!(name: "1920's Driving Gloves" , description: 'Leather' , unit_price: 2999 )

    visit merchant_items_path(merchant_1.id)

    click_link 'Dangly Earings' 
    
    expect(current_path).to eq(merchant_item_path(merchant_1.id, item_1.id))
  end

  it 'has secton for enabled items and disabled items' do 
    merchant_1 = Merchant.create(name: "Ray's Handmade Jewelry")
    item_1 = merchant_1.items.create!(name: "Dangly Earings" , description: 'They tickle your neck.', unit_price: 1500, status: "Enabled" )
    item_2 = merchant_1.items.create!(name: "Gold Ring" , description: 'There are many rings of power...' , unit_price: 4999, status: "Disabled" )
    item_3 = merchant_1.items.create!(name: "Silver Ring" , description: 'A simple, classic, and versatile piece' , unit_price: 2999, status: "Disabled" )
    
    visit merchant_items_path(merchant_1.id)

    within("#disabled-0") do 
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_3.name)
      expect(page).to_not have_content(item_1.name)
    end

    within("#enabled-0") do 
      expect(page).to have_content(item_1.name)
      expect(page).to_not have_content(item_3.name)
    end
  end

  it 'has a button to change item status to Enabled' do 
    merchant_1 = Merchant.create(name: "Ray's Handmade Jewelry")
    item_1 = merchant_1.items.create!(name: "Dangly Earings" , description: 'They tickle your neck.', unit_price: 1500, status: "Enabled" )
    item_2 = merchant_1.items.create!(name: "Gold Ring" , description: 'There are many rings of power...' , unit_price: 4999, status: "Disabled" )
    item_3 = merchant_1.items.create!(name: "Silver Ring" , description: 'A simple, classic, and versatile piece' , unit_price: 2999, status: "Disabled" )
    
    visit merchant_items_path(merchant_1.id)

    within("#disabled-1") do 
      click_button "Enable Item"
    end
    changed_item = Item.last
    
    expect(current_path).to eq(merchant_items_path(merchant_1.id))
    expect(changed_item.name).to appear_before("Disabled Items")
    expect(changed_item.status).to eq("Enabled")
  end 

  it 'has a button to change item status to Disabled' do 
    merchant_1 = Merchant.create(name: "Ray's Handmade Jewelry")
    item_1 = merchant_1.items.create!(name: "Dangly Earings" , description: 'They tickle your neck.', unit_price: 1500, status: "Enabled" )
    item_2 = merchant_1.items.create!(name: "Gold Ring" , description: 'There are many rings of power...' , unit_price: 4999, status: "Disabled" )
    item_3 = merchant_1.items.create!(name: "Silver Ring" , description: 'A simple, classic, and versatile piece' , unit_price: 2999, status: "Disabled" )
    
    visit merchant_items_path(merchant_1.id)

    within("#enabled-0") do 
      click_button "Disable Item"
    end
    nu_changed_item = Item.last
    expect(current_path).to eq(merchant_items_path(merchant_1.id))
    expect("Disabled Items").to appear_before(nu_changed_item.name)
    expect(nu_changed_item.status).to eq("Disabled")
  end
end