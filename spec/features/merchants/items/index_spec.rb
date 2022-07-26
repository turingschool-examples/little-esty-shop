require 'rails_helper'

RSpec.describe 'Merchant Item Index' do
    describe 'As a merchant' do
        describe 'When I visit my merchant items index page' do
            before :each do 
                @merchant1 = Merchant.create!(name: 'Stevie Plunder')
                @merchant2 = Merchant.create!(name: 'Dave Einstein')
                @hammer = @merchant1.items.create!(name: 'hammer', description: 'it is hammer time', unit_price: 2500)                
                @bat = @merchant2.items.create!(name: 'bat', description: 'Hit a baseball with it', unit_price: 4500)                
            end
            
            it 'I see a list of the names of all of my items and I do not see items for any other merchant' do
                visit merchant_items_path(@merchant1.id)

                expect(page).to have_content(@hammer.name)
                expect(page).to_not have_content(@bat.name)
            end
        end
    end
end
            