require 'rails_helper'

RSpec.describe 'merchant items index page' do
  describe 'as a merchant' do
    describe 'when i visit my merchant items index page' do
      it 'i see a list of the names of all of my items and i do not see items for any other merchant' do
        merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        item_1 = merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 25000000)
        item_2 = merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 10000000)
        merchant_2 = Merchant.create!(name: "Bill's Less Rare Guitars")
        item_3 = merchant_2.items.create!(name: "2006 Ibanez GX500",
                                          description: "Green Burst Finish, Rosewood Fingerboard",
                                          unit_price: 50000)

        visit "/merchants/#{merchant_1.id}/items"

        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).not_to have_content(item_3.name)
      end

      it 'next to each item name, i see a button to disable or enable that item' do
        merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        item_1 = merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 25000000)
        item_2 = merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 10000000)
        item_3 = merchant_1.items.create!(name: "1968 Gibson SG",
                                        description: "Cherry Red Finish, Rosewood Fingerboard",
                                        unit_price: 400000,
                                        status: 1)

        visit "/merchants/#{merchant_1.id}/items"

        within("#item-#{item_1.id}") do
          expect(page).to have_button("Enable")
        end

        within("#item-#{item_2.id}") do
          expect(page).to have_button("Enable")
        end

        within("#item-#{item_3.id}") do
          expect(page).to have_button("Disable")
        end
      end

      it 'when i click the disable/enable button, i am redirected back to the
          items index and i see that that items status has changed' do
        merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        item_1 = merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 25000000)
        item_2 = merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 10000000)
        item_3 = merchant_1.items.create!(name: "1968 Gibson SG",
                                        description: "Cherry Red Finish, Rosewood Fingerboard",
                                        unit_price: 400000,
                                        status: 1)

        visit "/merchants/#{merchant_1.id}/items"

        within("#item-#{item_1.id}") do
          click_button("Enable")
        end

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")

        within("#item-#{item_1.id}") do
          expect(page).to have_button("Disable")
        end

        within("#item-#{item_2.id}") do
          expect(page).to have_button("Enable")
        end

        within("#item-#{item_3.id}") do
          click_button("Disable")
        end

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")

        within("#item-#{item_3.id}") do
          expect(page).to have_button("Enable")
        end
      end

      it 'i see two sections: one for Enabled Items and one for Disabled Items' do
        merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        item_1 = merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 25000000,
                                        status: 1)
        item_2 = merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 10000000)
        item_3 = merchant_1.items.create!(name: "1968 Gibson SG",
                                        description: "Cherry Red Finish, Rosewood Fingerboard",
                                        unit_price: 400000,
                                        status: 1)
        item_4 = merchant_1.items.create!(name: "1982 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 600000)

        visit "/merchants/#{merchant_1.id}/items"

        within("#disabled_items") do
          expect(page).to have_content("Disabled Items")
          expect(page).to have_content(item_2.name)
          within("#item-#{item_2.id}") do
            expect(page).to have_button("Enable")
          end

          expect(page).to have_content(item_4.name)
          within("#item-#{item_4.id}") do
            expect(page).to have_button("Enable")
          end

          expect(page).not_to have_content(item_1.name)
          expect(page).not_to have_content(item_3.name)
          expect(page).not_to have_button("Disable")
        end

        within("#enabled_items") do
          expect(page).to have_content("Enabled Items")

          expect(page).to have_content(item_1.name)
          within("#item-#{item_1.id}") do
            expect(page).to have_button("Disable")
          end

          expect(page).to have_content(item_3.name)
          within("#item-#{item_3.id}") do
            expect(page).to have_button("Disable")
          end

          expect(page).not_to have_content(item_2.name)
          expect(page).not_to have_content(item_4.name)
          expect(page).not_to have_button("Enable")
        end
      end
    end
  end
end
