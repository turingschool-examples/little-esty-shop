require 'rails_helper'

RSpec.describe 'merchant items index page' do
  
  it 'lists all items for a merchant' do
    mariah = Merchant.create!(name: "Mariah Ahmed")
    terry = Merchant.create!(name: "Terry Peeples")
  
    pen = mariah.items.create!(name: "pen", description: "writes stuff", unit_price: 33)
    marker = mariah.items.create!(name: "marker", description: "writes stuff", unit_price: 23)
    pencil = mariah.items.create!(name: "pencil", description: "writes stuff", unit_price: 13)
  
    socks = terry.items.create!(name: "socks", description: "keeps feet warm", unit_price: 8)
    shoes = terry.items.create!(name: "shoes", description: "provides arch support", unit_price: 68)
    
    visit merchant_item_index_path(mariah)
    
    expect(page).to have_content(pen.name)
    expect(page).to have_content(marker.name)
    expect(page).to have_content(pencil.name)
    expect(page).to have_no_content(socks.name)
  end
  
  describe 'story 9' do 
    #     As a merchant
    # When I visit my items index page
    # Next to each item name I see a button to disable or enable that item.
    # When I click this button
    # Then I am redirected back to the items index
    # And I see that the items status has changed
    
    it 'has a button to disable or enable item' do 
      mariah = Merchant.create!(name: "Mariah Ahmed")
      terry = Merchant.create!(name: "Terry Peeples")
    
      pen = mariah.items.create!(name: "pen", description: "writes stuff", unit_price: 33)
      marker = mariah.items.create!(name: "marker", description: "writes stuff", unit_price: 23)
      pencil = mariah.items.create!(name: "pencil", description: "writes stuff", unit_price: 13)
    
      socks = terry.items.create!(name: "socks", description: "keeps feet warm", unit_price: 8)
      shoes = terry.items.create!(name: "shoes", description: "provides arch support", unit_price: 68)
      
      visit merchant_item_index_path(mariah)
      expect(page).to have_button("Enable")
    end
    it 'will take me back to the items index page when the button is clicked' do
      mariah = Merchant.create!(name: "Mariah Ahmed")
      terry = Merchant.create!(name: "Terry Peeples")
      
      pen = mariah.items.create!(name: "pen", description: "writes stuff", unit_price: 33)
      # marker = mariah.items.create!(name: "marker", description: "writes stuff", unit_price: 23)
      # pencil = mariah.items.create!(name: "pencil", description: "writes stuff", unit_price: 13)
      
      socks = terry.items.create!(name: "socks", description: "keeps feet warm", unit_price: 8)
      shoes = terry.items.create!(name: "shoes", description: "provides arch support", unit_price: 68)
      
      visit merchant_item_index_path(mariah)
      click_button 'Enable'

      expect(page).to have_current_path(merchant_item_index_path(mariah))
    end
    it 'changes the items status' do
      mariah = Merchant.create!(name: "Mariah Ahmed")
      terry = Merchant.create!(name: "Terry Peeples")
      
      pen = mariah.items.create!(name: "pen", description: "writes stuff", unit_price: 33)
      marker = mariah.items.create!(name: "marker", description: "writes stuff", unit_price: 23)
      pencil = mariah.items.create!(name: "pencil", description: "writes stuff", unit_price: 13)
      
      socks = terry.items.create!(name: "socks", description: "keeps feet warm", unit_price: 8)
      shoes = terry.items.create!(name: "shoes", description: "provides arch support", unit_price: 68)
      
      visit merchant_item_index_path(mariah)
      
      expect(pen.status).to eq(0)
      
      within("#item-#{pen.id}") do 
        click_button 'Enable'
      end
      
      pen.reload
      
      expect(page).to have_current_path(merchant_item_index_path(mariah))
      expect(pen.status).to eq(1)
      expect(page).to have_button("Disable")
      
    end
  end
  
  describe "story 10" do
    #     As a merchant,
    # When I visit my merchant items index page
    # Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
    # And I see that each Item is listed in the appropriate section
    
    it 'has has a section for enabled and one for disabled items' do
      mariah = Merchant.create!(name: "Mariah Ahmed")
      terry = Merchant.create!(name: "Terry Peeples")
      
      pen = mariah.items.create!(name: "pen", description: "writes stuff", unit_price: 33)
      marker = mariah.items.create!(name: "marker", description: "writes stuff", unit_price: 23)
      pencil = mariah.items.create!(name: "pencil", description: "writes stuff", unit_price: 13)
      
      socks = terry.items.create!(name: "socks", description: "keeps feet warm", unit_price: 8)
      shoes = terry.items.create!(name: "shoes", description: "provides arch support", unit_price: 68)
      
      visit merchant_item_index_path(mariah)
      
      
      expect(page).to have_content("Enabled")
      expect(page).to have_content("Disabled")
    end
  end
end
