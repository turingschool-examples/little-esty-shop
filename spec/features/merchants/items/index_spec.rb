require 'rails_helper'

RSpec.describe 'Merchant Item Index' do
    describe 'As a merchant' do
        describe 'When I visit my merchant items index page' do
            before :each do 
                @merchant1 = Merchant.create!(name: 'Stevie Plunder')
                @merchant2 = Merchant.create!(name: 'Dave Einstein')
                @hammer = @merchant1.items.create!(name: 'hammer', description: 'it is hammer time', unit_price: 2500)                
                @candlestick = @merchant1.items.create!(name: 'candlestick', description: 'put a candle on it...or beat someone with it', unit_price: 2000)                
                @bat = @merchant2.items.create!(name: 'bat', description: 'Hit a baseball with it', unit_price: 4500)                
            end
            
            it 'I see a list of the names of all of my items and I do not see items for any other merchant' do
                visit merchant_items_path(@merchant1.id)
                
                expect(page).to have_content(@hammer.name)
                expect(page).to have_content(@candlestick.name)
                expect(page).to_not have_content(@bat.name)
            end
            
            it 'when I click on the name of an item from the merchan items index page, then I am taken to that merchants items show page' do
                visit merchant_items_path(@merchant1.id)
                
                click_link "#{@hammer.name}"
                
                expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@hammer.id}")

                expect(page).to have_content(@hammer.name)
                expect(page).to have_content("Description: #{@hammer.description}")
                expect(page).to have_content("Unit Price: #{@hammer.unit_price}")
            end
        end
    end
end
            