require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  before :each do
    @walmart = Merchant.create!(name: "Wal-Mart")

    @target = Merchant.create!(name: "Target")

    @costco = Merchant.create!(name: "Costco")

    @pencil = Item.create!( name: "Pencil",
                            description: "Sharpen it and write with it.",
                            unit_price: 199,
                            merchant_id: @walmart.id)

    @marker = Item.create!( name: "Marker",
                            description: "Washable!",
                            unit_price: 159,
                            merchant_id: @walmart.id)

    @eraser = Item.create!( name: "Eraser",
                            description: "Use it to fix mistakes.",
                            unit_price: 205,
                            merchant_id: @walmart.id)

    @highlighter = Item.create!( name: "Highlighter",
                            description: "Highlight things and make them yellow!",
                            unit_price: 305,
                            merchant_id: @target.id)
  end

  # User Story 1
  # Merchant Items Index Page

  # As a merchant,
  # When I visit my merchant items index page ("merchants/merchant_id/items")
  # I see a list of the names of all of my items
  # And I do not see items for any other merchant
  it 'has a list of all of the items for a merchant' do
    visit "/merchants/#{@walmart.id}/items"

    within '#items-section' do
      expect(page).to have_content(@pencil.name)
      expect(page).to have_content(@marker.name)
      expect(page).to have_content(@eraser.name)
      expect(page).to_not have_content(@highlighter.name)
    end
  end

  # User Story 2
  # Merchant Items Show Page

  # As a merchant,
  # When I click on the name of an item from the merchant items index page,
  # Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)
  # And I see all of the item's attributes including:

  # Name
  # Description
  # Current Selling Price
  it 'has links to show pages of merchant items' do
    visit "/merchants/#{@walmart.id}/items"

    within '#items-section' do
      expect(page).to_not have_content(@highlighter.name)

      within "#item-#{@pencil.id}" do
        expect(page).to have_link("#{@pencil.name}", href: "/merchants/#{@walmart.id}/items/#{@pencil.id}")
      end

      within "#item-#{@marker.id}" do
        expect(page).to have_link("#{@marker.name}", href: "/merchants/#{@walmart.id}/items/#{@marker.id}")
      end

      within "#item-#{@eraser.id}" do
        expect(page).to have_link("#{@eraser.name}", href: "/merchants/#{@walmart.id}/items/#{@eraser.id}")
      end
    end
  end

  it 'has links to take you to a merchant item show page' do
    visit "/merchants/#{@walmart.id}/items"

    click_link "#{@pencil.name}"

    expect(current_path).to eq("/merchants/#{@walmart.id}/items/#{@pencil.id}")
  end
end