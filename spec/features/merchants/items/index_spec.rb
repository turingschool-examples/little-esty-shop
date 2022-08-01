require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  it "can see a list of all my items and not items for other merchants" do
    merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
    merchant2 = Merchant.create!(name: "Britches Eckles", created_at: Time.now, updated_at: Time.now)

    item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item2 = Item.create!(name: "Watch", description: "wearable", unit_price: 400, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item3 = Item.create!(name: "Clock", description: "household", unit_price: 300, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item4 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )
    item5 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )

    visit merchant_items_path(merchant1)

    expect(page).to have_content("Josey Wales")
    expect(page).to_not have_content("Britches Eckles")
    expect(page).to have_content("Name: Camera")
    expect(page).to_not have_content("Name: Bone")
  end 

  it 'items are links' do
    merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
    merchant2 = Merchant.create!(name: "Britches Eckles", created_at: Time.now, updated_at: Time.now)

    item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
    item4 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )
    item5 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )
    
    visit merchant_items_path(merchant1)

    expect(page).to have_link('Camera')

    click_on "Camera"

    expect(current_path).to eq(merchant_items_path(merchant1, item1))
  end

  describe 'Disable/Enable' do
    it 'shows/changes the items availiblity' do
      # Merchant Item Disable/Enable
      # As a merchant
      # When I visit my items index page
      # Next to each item name I see a button to disable or enable that item.
      # When I click this button
      # Then I am redirected back to the items index
      # And I see that the items status has changed


      merchant1 = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
      merchant2 = Merchant.create!(name: "Britches Eckles", created_at: Time.now, updated_at: Time.now)
  
      item1 = Item.create!(name: "Camera", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item2 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
      item3 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )

      visit merchant_items_path(merchant1)

      within ".merchant_item-#{item1.id}", match: :first do
        item = Item.find(item1.id)
        expect(item.availability).to eq("enable")
        
        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable" )

        click_button "Disable"
        item = Item.find(item1.id)
        expect(item.availability).to eq("disable")

        expect(current_path).to eq(merchant_items_path(merchant1))
        expect(page).to_not have_button("Disable")
        expect(page).to have_button("Enable")

        click_button "Enable"
        item = Item.find(item1.id)
        expect(item.availability).to eq("enable")

        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")
      end

      within ".merchant_item-#{item2.id}" do
        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")

        click_button "Disable"

        expect(current_path).to eq(merchant_items_path(merchant1))
        expect(page).to_not have_button("Disable")
        expect(page).to have_button("Enable")

        click_button "Enable"

        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")
      end

      within ".merchant_item-#{item3.id}" do
        expect(item3.availability).to eq('enable')
        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")

        click_button "Disable"

        expect(current_path).to eq(merchant_items_path(merchant1))
        expect(page).to_not have_button("Disable")
        expect(page).to have_button("Enable")

        click_button "Enable"

        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")
      end

    end

    it 'has sections for enable/disabled items' do
      
    end

    it 'groups by item availability status' do
      
    end
  end
end

# within ".merchant_item-#{item1.id}" do
  # expect(item1.availability).to eq("enable")

  # click_button "Disable"

  # expect(current_path).to eq(merchant_items_path(merchant1))
  # expect(item1.availability).to eq("disable")
  # expect(item1.availability).to_not eq("enable")
# end

# <% @merchant.items.each do |item| %>
#   <div class="merchant_item-<%=item.id%>">
#     <%if item.availability == "enable" %>
#       <%= link_to "Name: #{item.name}", merchant_items_path(@merchant, item)%> 
#       <%= button_to "Disable", "/merchants/#{@merchant.id}/items/#{item.id}", method: :patch, params: { availability: "disable" }  %>
#     <%else item.availability == "disable" %>
#       <%= link_to "Name: #{item.name}", merchant_items_path(@merchant, item)%> 
#       <%= button_to "Enable", "/merchants/#{@merchant.id}/items/#{item.id}", method: :patch, params: { availability: "enable" }  %>
#     <% end %>
#   </div>
# <% end %>

