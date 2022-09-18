require 'rails_helper'

RSpec.describe 'Merchants Item Index' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @items_1 = create_list(:item, 10, merchant: @merchant_1)
    @items_2 = create_list(:item, 10, merchant: @merchant_2)
    @items_3 = create_list(:item, 2, merchant: @merchant_1, active_status: :disabled)
    @items_4 = create_list(:item, 2, merchant: @merchant_2, active_status: :disabled)
  end

  # When I visit my merchant items index page ("merchants/merchant_id/items")
  # I see a list of the names of all of my items
  # And I do not see items for any other merchant
  describe 'user story 6' do
    it 'I see a list of the names of all of my items' do

      visit merchant_items_path(@merchant_1)

      within("#item-#{@items_1[0].id}") do
        expect(page).to have_content("#{@items_1[0].name}")
        expect(page).to_not have_content("#{@items_2[0].name}")
      end

      within("#item-#{@items_1[1].id}") do
        expect(page).to have_content("#{@items_1[1].name}")
        expect(page).to_not have_content("#{@items_1[4].name}")
      end

    visit merchant_items_path(@merchant_2)

      within("#item-#{@items_2[0].id}") do
        expect(page).to have_content("#{@items_2[0].name}")
        expect(page).to_not have_content("#{@items_1[0].name}")
      end

      within("#item-#{@items_2[1].id}") do
        expect(page).to have_content("#{@items_2[1].name}")
        expect(page).to_not have_content("#{@items_2[5].name}")
      end
    end
  end

  # As a merchant,
  # When I click on the name of an item from the merchant items index page,
  # Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)
  # And I see all of the item's attributes including:
  describe 'user story 7' do
    it 'When I click on the name of an item I am taken to that merchants item show page' do

      visit "/merchants/#{@merchant_1.id}/items"

      within("#item-#{@items_1[0].id}") do
        click_on "#{@items_1[0].name}"
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@items_1[0].id}")
      end

      visit "/merchants/#{@merchant_2.id}/items"

      within("#item-#{@items_2[6].id}") do
        click_on "#{@items_2[6].name}"
        expect(current_path).to eq("/merchants/#{@merchant_2.id}/items/#{@items_2[6].id}")
      end
    end

    it 'I see all of the items attributes' do

      @items_1.each do |item|
        visit merchant_item_path(@merchant_1, item)
        expect(page).to have_content(item.name)
        expect(page).to have_content(item.description)
        expect(page).to have_content(item.unit_price)
      end

      @items_2.each do |item|
        visit merchant_item_path(@merchant_2, item)
        expect(page).to have_content(item.name)
        expect(page).to have_content(item.description)
        expect(page).to have_content(item.unit_price)
      end
    end
  end

  # As a merchant
  # When I visit my items index page
  # Next to each item name I see a button to disable or enable that item.
  # When I click this button
  # Then I am redirected back to the items index
  # And I see that the items status has changed
  describe 'user story 9' do
    it 'Next to each item name I see a button to disable or enable that item' do

      visit merchant_items_path(@merchant_1)

      within("#item-#{@items_1[0].id}") do
        expect(page).to have_button("Disable")
      end

      within("#item-#{@items_1[1].id}") do
        expect(page).to have_button("Disable")
      end

      within("#item-#{@items_3[0].id}") do
        expect(page).to have_button("Enable")
      end

      within("#item-#{@items_3[1].id}") do
        expect(page).to have_button("Enable")
      end

      visit merchant_items_path(@merchant_2)

      within("#item-#{@items_2[0].id}") do
        expect(page).to have_button("Disable")
      end

      within("#item-#{@items_4[0].id}") do
        expect(page).to have_button("Enable")
      end
    end

    it "When I click this button I am redirected back to the items index" do
      visit merchant_items_path(@merchant_1)

      within("#item-#{@items_1[0].id}") do
        click_button "Disable"
      end
        expect(current_path).to eq(merchant_items_path(@merchant_1))
    end

    it "I see the items status has changed" do

      visit merchant_items_path(@merchant_1)

      within("#item-#{@items_1[0].id}") do
        expect(page).to have_button("Disable")
        click_button "Disable"
        expect(page).to have_button("Enable")
      end

      visit merchant_items_path(@merchant_2)

      within("#item-#{@items_4[1].id}") do
        expect(page).to have_button("Enable")
        click_button "Enable"
        expect(page).to have_button("Disable")
      end
    end
  end

  # As a merchant,
  # When I visit my merchant items index page
  # Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
  # And I see that each Item is listed in the appropriate section
  describe 'user story 10' do
    it 'Then I see two sections, one for Enabled Items and one for Disabled Items' do

      visit merchant_items_path(@merchant_1)

      within("#enabled-items") do
        expect(page).to have_content("Enabled Items")
      end

      within("#disabled-items") do
        expect(page).to have_content("Disabled Items")
      end

    end

    it 'I see that each Item is listed in the appropriate section' do

      visit merchant_items_path(@merchant_1)

      within("#enabled-items") do
        within("#item-#{@items_1[0].id}") do
          expect(page).to have_content("#{@items_1[0].name}")
          expect(page).to have_button("Disable")
        end

        within("#item-#{@items_1[1].id}") do
          expect(page).to have_content("#{@items_1[1].name}")
          expect(page).to have_button("Disable")
        end
      end

      within("#disabled-items") do
        within("#item-#{@items_3[0].id}") do
          expect(page).to have_content("#{@items_3[0].name}")
          expect(page).to have_button("Enable")
        end

        within("#item-#{@items_3[1].id}") do
          expect(page).to have_content("#{@items_3[1].name}")
          expect(page).to have_button("Enable")
        end
      end

      visit merchant_items_path(@merchant_2)

      within("#enabled-items") do
        within("#item-#{@items_2[0].id}") do
          expect(page).to have_content("#{@items_2[0].name}")
          expect(page).to have_button("Disable")
        end

        within("#item-#{@items_2[1].id}") do
          expect(page).to have_content("#{@items_2[1].name}")
          expect(page).to have_button("Disable")
        end
      end

      within("#disabled-items") do
        within("#item-#{@items_4[0].id}") do
          expect(page).to have_content("#{@items_4[0].name}")
          expect(page).to have_button("Enable")
        end

        within("#item-#{@items_4[1].id}") do
          expect(page).to have_content("#{@items_4[1].name}")
          expect(page).to have_button("Enable")
        end
      end
    end
  end
end
