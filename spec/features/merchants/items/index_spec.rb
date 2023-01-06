require 'rails_helper'

RSpec.describe 'merchant items index page' do
  # before :each do
  #   mariah = Merchant.create!(name: "Mariah Ahmed")
  #   terry = Merchant.create!(name: "Terry Peeples")

  #   pen = mariah.items.create!(name: "pen", description: "writes stuff", unit_price: 33)
  #   marker = mariah.items.create!(name: "marker", description: "writes stuff", unit_price: 23)
  #   pencil = mariah.items.create!(name: "pencil", description: "writes stuff", unit_price: 13)

  #   socks = terry.items.create!(name: "socks", description: "keeps feet warm", unit_price: 8)
  #   shoes = terry.items.create!(name: "shoes", description: "provides arch support", unit_price: 68)
    
  # end
  
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
    it 'changes the items status'
  end
end
