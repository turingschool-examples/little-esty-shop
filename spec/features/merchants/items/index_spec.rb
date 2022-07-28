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

  # User Story 6
  # Merchant Items Index Page

  # As a merchant,
  # When I visit my merchant items index page ("merchants/merchant_id/items")
  # I see a list of the names of all of my items
  # And I do not see items for any other merchant
  it 'has a list of all of the items for a merchant' do
    visit "/merchants/#{@walmart.id}/items"

    within '#disabled-items-section' do
      expect(page).to have_content(@pencil.name)
      expect(page).to have_content(@marker.name)
      expect(page).to have_content(@eraser.name)
      expect(page).to_not have_content(@highlighter.name)
    end
  end

  # User Story 7
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

    within '#disabled-items-section' do
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

  it 'has a button to enable/disable an item' do
    visit "/merchants/#{@walmart.id}/items"

    within '#disabled-items-section' do
      within "#item-#{@pencil.id}" do
        expect(page).to have_button("Enable")
      end
    end
  end

  it 'can change the status to enabled' do
    visit "/merchants/#{@walmart.id}/items"

    within '#disabled-items-section' do
      within "#item-#{@pencil.id}" do
        click_button 'Enable'
      end
    end

    expect(current_path).to eq("/merchants/#{@walmart.id}/items")

    within '#enabled-items-section' do
      within "#item-#{@pencil.id}" do
        expect(page).to have_content(@pencil.name)
        expect(page).to have_button("Disable")
      end
      expect(page).to_not have_content(@marker.name)
    end
  end

  it 'can change the status to disabled' do
    @pen = Item.create!( name: "pen",
                         description: "Never needs to be sharpened.",
                         unit_price: 150,
                         merchant_id: @walmart.id,
                         status: 'enabled')
    visit "/merchants/#{@walmart.id}/items"
    within '#enabled-items-section' do
      within "#item-#{@pen.id}" do
        click_button 'Disable'
      end
    end

    expect(current_path).to eq("/merchants/#{@walmart.id}/items")

    within '#disabled-items-section' do
      within "#item-#{@pen.id}" do
        expect(page).to have_content(@pen.name)
        expect(page).to have_button("Enable")
      end
    end
  end

  it 'has a enabled section and a disabled section' do
    @pen = Item.create!( name: "pen",
                         description: "Never needs to be sharpened.",
                         unit_price: 150,
                         merchant_id: @walmart.id,
                         status: 'enabled')
    visit "/merchants/#{@walmart.id}/items"

    within '#enabled-items-section' do
      within "#item-#{@pen.id}" do
        expect(page).to have_content(@pen.name)
        expect(page).to_not have_content(@marker.name)
      end
    end

    within '#disabled-items-section' do
      within "#item-#{@pencil.id}" do
        expect(page).to have_content(@pencil.name)
        expect(page).to_not have_content(@pen.name)
      end
    end

  end
end
