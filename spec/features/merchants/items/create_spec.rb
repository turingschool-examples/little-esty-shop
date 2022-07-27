    # Merchant Item Create

    # As a merchant
    # When I visit my items index page
    # I see a link to create a new item.
    # When I click on the link,
    # I am taken to a form that allows me to add item information.


    
    # When I fill out the form I click ‘Submit’
    # Then I am taken back to the items index page
    # And I see the item I just created displayed in the list of items.
    # And I see my item was created with a default status of disabled.


require 'rails_helper'

RSpec.describe 'merchant items new page' do
    it 'renders the new form' do
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

        visit "/merchants/#{merchant_1.id}/items/new"
        save_and_open_page
        expect(page).to have_content('New Item')
        expect(find('form')).to have_content('Name')
        expect(find('form')).to have_content('Description')
        expect(find('form')).to have_content('Unit price')
    end
end 