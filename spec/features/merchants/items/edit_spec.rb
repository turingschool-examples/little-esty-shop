require 'rails_helper'

RSpec.describe 'Merchant Items Edit page' do
  before :each do 
    @merchant_1 = Merchant.create!(name: 'Schroeder-Jerde')
    @merchant_2 = Merchant.create!(name: 'Rempel and Jones')
    @merchant_3 = Merchant.create!(name: 'Willms and Sons')

    @item_1 = @merchant_1.items.create!(name: 'Qui Esse', description: 'Nihil autem sit odio inventore deleniti', unit_price: 75107)
    @item_2 = @merchant_1.items.create!(name: 'Autem Minima', description: 'Cumque consequuntur ad', unit_price: 67076)
    @item_3 = @merchant_1.items.create!(name: 'Ea Voluptatum', description: 'Sunt officia eum qui molestiae', unit_price: 32301)
    @item_4 = @merchant_1.items.create!(name: 'Nemo Facere', description: 'Sunt eum id eius magni consequuntur delectus veritatis', unit_price: 4291)
    @item_5 = @merchant_1.items.create!(name: 'Expedita Aliquam', description: 'Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum', unit_price: 68723)
    @item_6 = @merchant_2.items.create!(name: 'Provident At', description: 'Numquam officiis reprehenderit eum ratione neque tenetur', unit_price: 15925)
    @item_7 = @merchant_2.items.create!(name: 'Expedita Fuga', description: 'Fuga assumenda occaecati hic dolorem tenetur dolores nisi', unit_price: 31163)
    @item_8 = @merchant_2.items.create!(name: 'Est Consequuntur', description: 'Reprehenderit est officiis cupiditate quia eos', unit_price: 34355)
    @item_9 = @merchant_2.items.create!(name: 'Quo Magnam', description: 'Culpa deleniti adipisci voluptates aut. Sed eum quisquam nisi', unit_price: 22582)
    @item_10 = @merchant_2.items.create!(name: 'Quidem Suscipit', description: 'Reiciendis sed aperiam culpa animi laudantium', unit_price: 34018)
  end

  # As a merchant,
  # When I visit the merchant show page of an item
  # I see a link to update the item information.
  # When I click the link
  # Then I am taken to a page to edit this item
  # And I see a form filled in with the existing item attribute information
  # When I update the information in the form and I click ‘submit’
  # Then I am redirected back to the item show page where I see the updated information
  # And I see a flash message stating that the information has been successfully updated.

  describe 'User story 8' do
    it 'has a link to update the item information' do
      visit merchant_item_path(@merchant_1.id, @item_1.id)

      expect(page).to have_link("Edit information for: #{@item_1.name}", :href => "/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")
    end

    it 'takes me to a page with a form that is filled with the item attributes, when I click the link' do
      visit merchant_item_path(@merchant_1.id, @item_1.id)

      expect(page).to have_link("Edit information for: #{@item_1.name}", :href => "/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")

      click_link("Edit information for: #{@item_1.name}") 

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")
      expect(page).to have_field('Name', with: "#{@item_1.name}")
      expect(page).to have_field('Description', with: "#{@item_1.description}")
      expect(page).to have_field('Unit price', with: "#{@item_1.unit_price}")
      expect(page).to have_button("Update")
    end

    it "can fill out a form, click 'update', and redirect to the item show page, where I see a flash message" do
      # visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit"
      visit edit_merchant_item_path(@merchant_1.id, @item_1.id)

      expect(page).to have_field('Name', with: "#{@item_1.name}")
      expect(page).to have_field('Description', with: "#{@item_1.description}")
      expect(page).to have_field('Unit price', with: "#{@item_1.unit_price}")
      expect(page).to have_button("Update")

      fill_in('Name', with: 'Updated description of Qui Esse version 2')
      fill_in('Description', with: 'Qui Esse version 2')
      click_button('Update')

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
      expect(page).to have_content("Item information has been successfully updated")
      expect(page).to have_content('Updated description of Qui Esse version 2')
      expect(page).to have_content('Qui Esse version 2')
    end
  end

  describe 'Sad Path testing' do
    it 'cannot update a merchant item if a field is empty' do
      visit edit_merchant_item_path(@merchant_1.id, @item_1.id)

      fill_in('Name', with: '')
      click_button('Update')

      expect(page).to have_content('Item was not updated, please update one of the fields.')
      expect(page).to have_button('Update')
    end
  end
end