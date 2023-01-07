require 'rails_helper'

RSpec.describe 'Merchant Items Index page' do
  before :each do 
    @merchant_1 = Merchant.create!(name: 'Schroeder-Jerde')
    @merchant_2 = Merchant.create!(name: 'Rempel and Jones')
    @merchant_3 = Merchant.create!(name: 'Willms and Sons')

    @item_1 = @merchant_1.items.create!(name: 'Qui Esse', description: 'Nihil autem sit odio inventore deleniti', unit_price: 75107, status: 'enabled')
    @item_2 = @merchant_1.items.create!(name: 'Autem Minima', description: 'Cumque consequuntur ad', unit_price: 67076, status: 'disabled')
    @item_3 = @merchant_1.items.create!(name: 'Ea Voluptatum', description: 'Sunt officia eum qui molestiae', unit_price: 32301)
    @item_4 = @merchant_1.items.create!(name: 'Nemo Facere', description: 'Sunt eum id eius magni consequuntur delectus veritatis', unit_price: 4291)
    @item_5 = @merchant_1.items.create!(name: 'Expedita Aliquam', description: 'Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum', unit_price: 68723)
    @item_6 = @merchant_2.items.create!(name: 'Provident At', description: 'Numquam officiis reprehenderit eum ratione neque tenetur', unit_price: 15925)
    @item_7 = @merchant_2.items.create!(name: 'Expedita Fuga', description: 'Fuga assumenda occaecati hic dolorem tenetur dolores nisi', unit_price: 31163)
    @item_8 = @merchant_2.items.create!(name: 'Est Consequuntur', description: 'Reprehenderit est officiis cupiditate quia eos', unit_price: 34355)
    @item_9 = @merchant_2.items.create!(name: 'Quo Magnam', description: 'Culpa deleniti adipisci voluptates aut. Sed eum quisquam nisi', unit_price: 22582)
    @item_10 = @merchant_2.items.create!(name: 'Quidem Suscipit', description: 'Reiciendis sed aperiam culpa animi laudantium', unit_price: 34018)
  end
  
#  As a merchant,
# When I visit my merchant items index page ("merchants/merchant_id/items")
# I see a list of the names of all of my items
# And I do not see items for any other merchant
  describe 'User story 6' do
    it 'displays a list of all merchant items for that particular merchant' do
      visit merchant_items_path(@merchant_1.id)
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_3.name)
        expect(page).to have_content(@item_4.name)
        expect(page).to have_content(@item_5.name)
        expect(page).to_not have_content(@item_6.name)
        expect(page).to_not have_content(@item_7.name)
        expect(page).to_not have_content(@item_8.name)
    end
  end
  
  # Part 1:
  # As a merchant,
  # When I click on the name of an item from the merchant items index page,
  # Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)

  # Part 2: And I see all of the item's attributes including:
  
  # - Name
  # - Description
  # - Current Selling Price
  describe 'User story 7 (part 1)' do
    it 'displays the item name as a link which links to the items show page' do
      visit merchant_items_path(@merchant_1.id)

      expect(page).to have_link("#{@item_1.name}", :href => "/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
      expect(page).to have_link("#{@item_2.name}", :href => "/merchants/#{@merchant_1.id}/items/#{@item_2.id}")
      expect(page).to_not have_link("#{@item_8.name}", :href => "/merchants/#{@merchant_2.id}/items/#{@item_8.id}")

      click_link("#{@item_1.name}")
      
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
    end
  end
  
# As a merchant
# When I visit my items index page ("merchants/merchant_id/items")
# Next to each item name I see a button to disable or enable that item.
# When I click this button
# Then I am redirected back to the items index
# And I see that the items status has changed
  describe 'User story 9' do
    it 'next to each name, I see a button to enable or disable that item' do
      visit merchant_items_path(@merchant_1.id)

      expect(page).to have_button('Enable')
      expect(page).to have_button('Disable')
    end
    
    it 'click the button and be redirected to the items index page, where the items status is changed' do
      visit merchant_items_path(@merchant_1.id)
      
      expect(@item_1.status).to eq('enabled')
      expect(page).to have_button('Disable', id: @item_1.id)
      expect(@item_2.status).to eq('disabled')
      expect(page).to have_button('Enable', id: @item_2.id)
      
      click_button('Disable', id: @item_1.id)
      
      expect(current_path).to eq(merchant_items_path(@merchant_1.id))
      @item_1.reload
      expect(@item_1.status).to eq('disabled')
      expect(@item_2.status).to eq('disabled')
    end
  end

# As a merchant,
# When I visit my merchant items index page
# Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
# And I see that each Item is listed in the appropriate section
  describe 'User story 10' do
    it 'has two sections for enabled and disabled items' do
      visit merchant_items_path(@merchant_1.id)
      # visit "merchants/#{@merchant_1.id}/items"

      within("#enabled_item_#{@item_1.id}") do
        expect(page).to have_button('Disable')
        expect(page).to_not have_button('Enable')
      end
      
      within("#enabled_item_#{@item_3.id}") do
        expect(page).to have_button('Disable')
      end
      
      within("#disabled_item_#{@item_2.id}") do
        expect(page).to have_button('Enable')
        expect(page).to_not have_button('Disable')
      end
      
      expect(page).to have_content('Enabled Items')
      expect(page).to have_content('Disabled Items')
    end 
  end

  # As a merchant
  # When I visit my items index page
  # I see a link to create a new item.
  # When I click on the link,
  # I am taken to a form that allows me to add item information.
  # When I fill out the form I click ‘Submit’
  # Then I am taken back to the items index page
  # And I see the item I just created displayed in the list of items.
  # And I see my item was created with a default status of disabled.
  describe 'user story 11' do 
    it 'displays a link to create a new item' do
      visit merchant_items_path(@merchant_1.id)
 
      click_link('Create a new item')

      expect(current_path).to eq(new_merchant_item_path(@merchant_1.id))

      fill_in 'Name', with: "Soccer Ball"
      fill_in 'Description', with: "black and white"
      fill_in 'Unit price', with: 22555
      click_button 'Submit'

      expect(current_path).to eq(merchant_items_path(@merchant_1.id))
      expect(page).to have_content("Soccer Ball")
      expect(page).to have_content("Status: disabled")
    end
    it 'sad path - cannot create a new item if a field is empty' do
      visit new_merchant_item_path(@merchant_1.id)

      fill_in 'Name', with: ""
      fill_in 'Description', with: ""
      fill_in 'Unit price', with: 
      click_button('Submit')

      expect(page).to have_content('Item was not created, please fill out all of the fields.')
      expect(page).to have_button('Submit')
    end
  end
end