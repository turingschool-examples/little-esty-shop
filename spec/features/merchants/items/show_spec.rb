require 'rails_helper'

RSpec.describe 'Merchant Item Show' do
    describe 'As a merchant' do
        describe 'When I visit the merchant items show page' do
            before :each do 
                @merchant1 = Merchant.create!(name: 'Stevie Plunder')
                @merchant2 = Merchant.create!(name: 'Dave Einstein')
                @hammer = @merchant1.items.create!(name: 'hammer', description: 'it is hammer time', unit_price: 2500)                
                @candlestick = @merchant1.items.create!(name: 'candlestick', description: 'put a candle on it...or beat someone with it', unit_price: 2000)                
                @bat = @merchant2.items.create!(name: 'bat', description: 'Hit a baseball with it', unit_price: 4500)                
            end
            
                it 'when I click on the name of an item from the merchant items index page
                then I am taken to that merchants items show page and I see all of the items attributes' do
                visit merchant_items_path(@merchant1.id)
                
                click_link "#{@hammer.name}"
                
                expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@hammer.id}")

                expect(page).to have_content(@hammer.name)
                expect(page).to have_content("Description: #{@hammer.description}")
                expect(page).to have_content("Unit Price: #{@hammer.unit_price}")
                expect(page).to_not have_content(@candlestick.name)
                expect(page).to_not have_content(@bat.name)
            end

            it 'I see a link to update the item information and when I click the link I am taken to a page to edit this item' do
                visit "/merchants/#{@merchant1.id}/items/#{@hammer.id}"
                
                click_link "Update Item Information"
                expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@hammer.id}/edit")
            end
            
            it 'and I see a form filled in with the existing item attribute information' do
                visit "/merchants/#{@merchant1.id}/items/#{@hammer.id}/edit"

                expect(page).to have_content("Update Item Information")
                
                within("#item-name") do
                    expect(page).to have_field('Name', with: @hammer.name)
                end
                within("#item-description") do
                    expect(page).to have_field('Description', with: @hammer.description)
                end
                within("#item-price") do
                    expect(page).to have_field('Unit Price', with: @hammer.unit_price)
                end
            end
            
            it "When I update the information in the form and I click ‘submit’
                then I am redirected back to the item show page where I see the updated information 
                and I see a flash message stating that the information has been successfully updated" do
                visit "/merchants/#{@merchant1.id}/items/#{@hammer.id}/edit"

                fill_in 'Name', with: 'Mallet'
                fill_in 'Description', with: "It's mallet time"
                fill_in 'Unit Price', with: 2599
                click_button 'Save'

                expect(page).to have_current_path("/merchants/#{@merchant1.id}/items/#{@hammer.id}")
                expect(page).to_not have_content(@hammer.name)
                expect(page).to_not have_content("Description: #{@hammer.description}")
                expect(page).to_not have_content("Unit Price: #{@hammer.unit_price}")
                expect(page).to have_content("Unit Price: 2599")
                expect(page).to have_content("Description: It's mallet time")
                expect(page).to have_content("Mallet")

                within("#flash-message") do
                    expect(page).to have_content("Mallet has been successfully updated")
                end
            end
        end
    end
end
            