require 'rails_helper'

RSpec.describe 'merchant items new page' do
    it 'renders the new form' do
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

        visit "/merchants/#{merchant_1.id}/items/new"

        expect(page).to have_content('New Item')
        expect(find('form')).to have_content('Name')
        expect(find('form')).to have_content('Description')
        expect(find('form')).to have_content('Unit price')
    end

    it 'creates the item and redirects to the merchant items new page' do
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

        visit "/merchants/#{merchant_1.id}/items/new"

        fill_in 'Name', with: 'Wine Bottle'
        fill_in 'Description', with: 'You can fill it with liquid!'
        fill_in 'Unit price', with: 5.25

        click_button 'Submit'

        expect(page).to have_current_path("/merchants/#{merchant_1.id}/items")
        expect(page).to have_content('Wine Bottle')
    end

    it 're-renders the new form if given invalid data' do
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

        visit "/merchants/#{merchant_1.id}/items/new"

        click_button 'Submit'

        expect(page).to have_current_path("/merchants/#{merchant_1.id}/items/new")
        expect(page).to have_content("Error: Name can't be blank, Description can't be blank, Unit price can't be blank")
    end
end 

       