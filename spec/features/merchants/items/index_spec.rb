require 'rails_helper'

RSpec.describe 'Merchant Items', type: :feature do
  describe 'Merchant Items Index' do

    let!(:sam) { Merchant.create!(name: "Sam's Sports") }
    let!(:bob) { Merchant.create!(name: "Bob's Beauties") } 
    let!(:arugula) { bob.items.create!(name: "Arugula", description: "This arugula", unit_price: 500) }
    let!(:tomato) { bob.items.create!(name: "Tomato", description: "This a few Tomatos", unit_price: 700) }
    let!(:football) { sam.items.create!(name: "Football", description: "This a football", unit_price: 3000) }
    let!(:baseball) { sam.items.create!(name: "Baseball", description: "This a baseball", unit_price: 2500) }
    let!(:glove) { sam.items.create!(name: "Baseball Glove", description: "This a baseball glove", unit_price: 4000, status: 1) }

    describe 'As a merchant' do 
      context 'When I visit my merchant items index page' do
        before (:each) do 
          visit merchant_items_path(sam.id)
        end

        it 'I see a list of the names of all my items' do
          expect(page).to have_content("#{sam.name}")
          expect(page).to have_content("New Item")
            
            expect(page).to have_content("#{football.name}")
            expect(page).to have_content("#{baseball.name}")
            expect(page).to have_content("#{glove.name}")
          
          expect(page).to_not have_content("#{arugula.name}")
          expect(page).to_not have_content("#{tomato.name}")
        end

        it "each item name is a link to that merchant's item's show page " do
          click_link football.name
          expect(current_path).to eq(merchant_item_path(sam.id, football.id))
        end

        it "each item name is a link to that merchant's item's show page " do
          click_link baseball.name
          expect(current_path).to eq(merchant_item_path(sam.id, baseball.id))
        end

        it "each item name is a link to that merchant's item's show page " do
          click_link glove.name
          expect(current_path).to eq(merchant_item_path(sam.id, glove.id))
        end

        it 'next to each item I see a button to disable or enable that item' do 
          within "div#enabled_items-#{football.id}" do
            expect(page).to have_button('Disable')
          end

          within "div#enabled_items-#{baseball.id}" do
            expect(page).to have_button('Disable')
          end

          within "div#disabled_items-#{glove.id}" do
            expect(page).to have_button('Enable')
          end
        end

        it 'changes the status of the item after the button click' do
     
          within "div#enabled_items-#{football.id}" do
            click_button 'Disable'
            football.reload
            expect(football.status).to eq('disabled')
            expect(current_path).to eq(merchant_items_path(sam))
          end
          
          within "div#enabled_items-#{baseball.id}" do
            click_button 'Disable'
            baseball.reload
            expect(baseball.status).to eq('disabled')
            expect(current_path).to eq(merchant_items_path(sam))

          end

          within "div#disabled_items-#{football.id}" do
            click_button 'Enable'
            glove.reload
            expect(glove.status).to eq('disabled')
            expect(current_path).to eq(merchant_items_path(sam))
          end
        end

        it 'displays enabled items in the enabled items section' do
         
          within "div#enabled_items-#{football.id}" do
            expect(page).to have_content(football.name)
          end

          within "div#enabled_items-#{baseball.id}" do
            expect(page).to have_content(baseball.name)
          end
        end

        it 'displays the disabled items in the disabled items section' do
          within "div#disabled_items-#{glove.id}" do
            expect(page).to have_content(glove.name)
          end
        end

        it 'displays items in correct sections after button click' do 
          within "div#enabled_items-#{football.id}" do
            expect(page).to have_content(football.name)
            click_on 'Disable'
          end

          football.reload
          
          within "div#disabled_items-#{football.id}" do
            expect(page).to have_content(football.name)
          end
        end

        it "I see a link to create a new item." do
          within('section#my_items') do
            expect(page).to have_link("New Item")
          end
        end
      end

      context 'When I visit my merchant items edit page' do
        before (:each) do 
          visit merchant_items_path(sam.id)
        end

        it "When I click on the link, I am taken to a form that allows me to add item information." do
          click_link "Create New Item"

          expect(current_path).to eq(new_merchant_item_path(sam.id))

          within ("section#new_item") do
            expect(page).to have_field("Name")
            expect(page).to have_field("Description")
            expect(page).to have_field("Unit Price")
          end
        end

        context "When I visit the Merchant Item Edit Form" do
          before (:each) do 
            visit new_merchant_item_path(sam.id)
          end

          it "When I fill out the form I click ‘Submit’ Then I am taken back to the items index page" do
            within("section#new_item") do
              fill_in "Name:", with: "Marijuana Tapestry"
              fill_in "Description", with: "Crushed velvet, 51.2 x 59.1 inches"
              fill_in "Unit Price", with: "7110"
              
              click_button "Submit"
            end
            
            expect(current_path).to eq(merchant_items_path(sam.id))
          end

          it 'when leave a form field blank, I get an error message and am returned to that Items edit page' do
            
            fill_in 'Name', with: 'Marijuana Tapestry'
            fill_in 'Description', with: ''
            fill_in 'Unit Price', with: ''
            click_button 'Submit'

            expect(current_path).to eq(new_merchant_item_path(sam.id))
            expect(page).to have_content("Description can't be blank")
            expect(page).to have_content("Unit price can't be blank")
          end
        end
      end
    end
  end
end