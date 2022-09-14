require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  let!(:carly) { Merchant.create!(name: "Carly Simon's Candy Silo")}
  let!(:bmv) { Merchant.create!(name: "Bavarian Motor Velocycles")}

  let!(:licorice) { carly.items.create!(name: "Licorice Funnels", description: "Some stuff", unit_price: 1200, enabled: true) }
  let!(:peanut) { carly.items.create!(name: "Peanut Bronzinos", description: "Some stuff", unit_price: 1500, enabled: true) }
  let!(:choco_waffle) { carly.items.create!(name: "Chocolate Waffles Florentine", description: "Some stuff", unit_price: 900, enabled: false) }
  let!(:hummus) { carly.items.create!(name: "Hummus Snocones", description: "Some stuff", unit_price: 1200, enabled: false) }

  let!(:skooter) { bmv.items.create!(name: "Hollenskooter", description: "Some stuff", unit_price: 12000, enabled: true) }
  let!(:rider) { bmv.items.create!(name: "Hosenpfloofer", description: "Some stuff", unit_price: 220000, enabled: true) }

  describe 'merchant items index page' do
    it 'lists the names of all items' do
      visit merchant_items_path(carly)
      save_and_open_page
      expect(page).to have_content(licorice.name)
      expect(page).to have_content(peanut.name)
      expect(page).to have_content(choco_waffle.name)
      expect(page).to have_content(hummus.name)
    end

    it 'does not list the names of other merchant items' do
      visit merchant_items_path(carly)
      
      expect(page).to_not have_content(skooter.name)
      expect(page).to_not have_content(rider.name)
    end

    it 'has sections for enabled and disabled items' do
      visit merchant_items_path(carly)

      within("#enabled_items") do
        expect(page).to have_content(licorice.name)
        expect(page).to_not have_content(hummus.name)
      end

      within("#disabled_items") do
        expect(page).to have_content(hummus.name)
        expect(page).to_not have_content(licorice.name)
      end
    end
    
    describe 'for each enabled item' do
      it 'has a button to disable item' do
        visit merchant_items_path(carly)

        within("#enabled_items") do
          expect(page).to have_content(licorice.name)
        end
  
        within("#disabled_items") do
          expect(page).to_not have_content(licorice.name)
        end

        within("#item-#{licorice.id}") do
          click_on "Disable"
        end

        expect(current_path).to eq(merchant_items_path(carly))

        within("#enabled_items") do
          expect(page).to_not have_content(licorice.name)
        end
  
        within("#disabled_items") do
          expect(page).to have_content(licorice.name)
        end
      end
    end

    describe 'for each disabled item' do
      it 'has a button to enable item' do
        visit merchant_items_path(carly)

        within("#disabled_items") do
          expect(page).to have_content(hummus.name)
        end
  
        within("#enabled_items") do
          expect(page).to_not have_content(hummus.name)
        end

        within("#item-#{hummus.id}") do
          click_on "Enable"
        end

        expect(current_path).to eq(merchant_items_path(carly))

        within("#disabled_items") do
          expect(page).to_not have_content(hummus.name)
        end
  
        within("#enabled_items") do
          expect(page).to have_content(hummus.name)
        end
      end
    end

    describe 'creating a new item' do
      it 'has a link to create a new item' do
        visit merchant_items_path(carly)
        
        expect(page).to have_link("Create New Item")

        click_link "Create New Item"

        expect(current_path).to eq(new_merchant_item_path(carly))
      end
    end
  end
end

# As a merchant,
# When I visit my merchant items index page ("merchants/merchant_id/items")
# I see a list of the names of all of my items
# And I do not see items for any other merchant

