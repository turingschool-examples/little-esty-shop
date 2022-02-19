equire 'rails_helper'

RSpec.describe 'Merchant Items Show page' do
  describe '#user story #34' do
    it 'displays the item attributes' do
      merchant1 = Merchant.create!(name: 'Primate Privleges')
      item1 = merchant1.items.create!(name: 'Monkey Paw', description: 'A furry mystery', unit_price: 3)
      visit "/merchants/#{merchant1.id}/items"

      click_on item1.name
      expect(page).to have_content(item1.name)
      expect(page).to have_content(item1.description)
      expect(page).to have_content(item1.unit_price)
    end
  end
end
