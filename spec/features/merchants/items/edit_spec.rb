require 'rails_helper'

RSpec.describe 'Merchant Item Edit page' do
  context 'when I visit a merchant item edit page' do
    before(:each) do
      @item = create(:item)

      visit "/merchants/#{@item.merchant.id}/items/#{@item.id}/edit"
    end

    it 'has a form with current info' do
      expect(page).to have_field('item[name]',        with: 'cookies')
      expect(page).to have_field('item[description]', with: 'whoopdie-doo!')
      expect(page).to have_field('item[unit_price]',  with: 12345 )
    end
  end
end

# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.
