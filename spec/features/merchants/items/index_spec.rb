require 'rails_helper'

RSpec.describe 'Merchant Items', type: :feature do
  describe 'Merchant Items Index' do

    let!(:sam) { Merchant.create!(name: "Sam's Sports") }
    let!(:bob) { Merchant.create!(name: "Bob's Beauties") } 
    let!(:arugula) { bob.items.create!(name: "Arugula", description: "This arugula", unit_price: 500) }
    let!(:tomato) { bob.items.create!(name: "Tomato", description: "This a few Tomatos", unit_price: 700) }
    let!(:football) { sam.items.create!(name: "Football", description: "This a football", unit_price: 3000) }
    let!(:baseball) { sam.items.create!(name: "Baseball", description: "This a baseball", unit_price: 2500) }
    let!(:glove) { sam.items.create!(name: "Baseball Glove", description: "This a baseball glove", unit_price: 4000) }

    before (:each) do 
      visit merchant_items_path(sam.id)
    end

    describe 'As a merchant' do 
      context 'When I visit my merchant items index page' do
        it 'I see a list of the names of all my items' do
          expect(page).to have_content("#{sam.name}")
          expect(page).to have_content("New Item")

          within 'ul#items_list' do
            expect(page).to have_content("#{football.name}")
            expect(page).to have_content("#{baseball.name}")
            expect(page).to have_content("#{glove.name}")
          end
          
          expect(page).to_not have_content("#{arugula.name}")
          expect(page).to_not have_content("#{tomato.name}")
        end

        it "each item name is a link to that merchant's item's show page " do
          within 'ul#items_list' do
            click_link football.name
            expect(current_path).to eq(merchant_item_path(sam.id, football.id))
          end
        end

        it "each item name is a link to that merchant's item's show page " do
          within 'ul#items_list' do
            click_link baseball.name
            expect(current_path).to eq(merchant_item_path(sam.id, baseball.id))
          end
        end

        it "each item name is a link to that merchant's item's show page " do
          within 'ul#items_list' do
            click_link glove.name
            expect(current_path).to eq(merchant_item_path(sam.id, glove.id))
          end
        end

        it "I see a link to create a new item." do
          within('section#my_items') do
            expect(page).to have_link("New Item")
          end
        end

        it "When I click on the link, I am taken to a form that allows me to add item information." do
          click_link "Create New Item"

          expect(current_path).to eq(new_merchant_item_path(sam.id))

          save_and_open_page

          within ("form#new_merchant_item") do
            expect(page).to have_field("Name")
            expect(page).to have_field("Description")
            expect(page).to have_field("Unit Price")
          end
        end
      end
    end
  end
end