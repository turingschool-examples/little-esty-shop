require 'rails_helper'

RSpec.describe 'Merchant Item Show Page' do
    describe 'display' do
        before :each do
            @merchant = Merchant.create!(name: "Tony")
            @item = @merchant.items.create!(name: "Shirt", description: "A blue shirt", unit_price: 30)  
            visit("/merchants/#{@merchant.id}/items/#{@item.id}")
        end

        it 'can display Item and its attributes' do
            expect(page).to have_content(@item.name)
            expect(page).to have_content(@item.description)
            expect(page).to have_content(@item.unit_price)
        end
    end
end