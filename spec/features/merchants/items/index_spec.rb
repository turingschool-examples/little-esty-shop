require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  let!(:carly) { Merchant.create!(name: "Carly Simon's Candy Silo")}
  let!(:bmv) { Merchant.create!(name: "Bavarian Motor Velocycles")}

  let!(:licorice) { carly.items.create!(name: "Licorice Funnels", description: "Some stuff", unit_price: 1200) }
  let!(:peanut) { carly.items.create!(name: "Peanut Bronzinos", description: "Some stuff", unit_price: 1500) }
  let!(:choco_waffle) { carly.items.create!(name: "Chocolate Waffles Florentine", description: "Some stuff", unit_price: 900) }
  let!(:hummus) { carly.items.create!(name: "Hummus Snocones", description: "Some stuff", unit_price: 1200) }

  let!(:skooter) { bmv.items.create!(name: "Hollenskooter", description: "Some stuff", unit_price: 12000) }
  let!(:rider) { bmv.items.create!(name: "Hosenpfloofer", description: "Some stuff", unit_price: 220000) }

  describe 'merchant items index page' do
    it 'lists the names of all items' do
      visit merchant_items_path(carly)

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

    # commented out because merchant items show tests this exactly. up to interpretation which spec it belongs in!
    # it 'items link to merchant item show page' do
    #   visit merchant_items_path(carly)

    #   click_on licorice.name

    #   expect(current_path).to eq(merchant_item_path(carly, licorice))
    # end
  end
end

# As a merchant,
# When I visit my merchant items index page ("merchants/merchant_id/items")
# I see a list of the names of all of my items
# And I do not see items for any other merchant