require 'rails_helper'

RSpec.describe 'Items New Spec Page', type: :feature do
  before(:each) do 
    repo_call = File.read('spec/fixtures/repo_call.json')
    stub_request(:get, 'https://api.github.com/repos/hadyematar23/little-esty-shop')
    .with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>"Bearer #{ENV['github_token']}",
        'User-Agent'=>'Faraday v2.7.4'
         }
    )
    .to_return(status: 200, body: repo_call, headers: {})
    
    contributors_call = File.read('spec/fixtures/contributors_call.json')
    stub_request(:get, 'https://api.github.com/repos/hadyematar23/little-esty-shop/contributors')
     .with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>"Bearer #{ENV['github_token']}",
        'User-Agent'=>'Faraday v2.7.4'
         }
    )
    .to_return(status: 200, body: contributors_call, headers: {})
  
    repo_call = File.read('spec/fixtures/pull_request_call.json')
    stub_request(:get, 'https://api.github.com/repos/hadyematar23/little-esty-shop/pulls?state=closed')
    .with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>"Bearer #{ENV['github_token']}",
        'User-Agent'=>'Faraday v2.7.4'
         }
    )
    .to_return(status: 200, body: repo_call, headers: {})

    @merchant1 = Merchant.create!(name: "Hady", uuid: 1) 
    @merchant2 = Merchant.create!(name: "Malena", uuid: 2) 

    @item_1 = @merchant1.items.create(name: "Salt", description: "it is salty", unit_price: 12, uuid: 1)
    @item_2 = @merchant1.items.create(name: "Pepper", description: "it is peppery", unit_price: 11, uuid: 2)
    @item_3 = @merchant2.items.create(name: "Spices", description: "it is spicy", unit_price: 13, uuid: 3)
    @item_4 = @merchant2.items.create(name: "Sand", description: "its all over the place", unit_price: 14, uuid: 4)
    @item_5 = @merchant2.items.create(name: "Water", description: "nice and liquidy", unit_price: 15, uuid: 5)
  end 

  describe "as a merchant" do 
    describe "visit items new page" do 
      it "I'm taken to a form that allows me to add item information" do 
        visit "/merchants/#{@merchant1.id}/items/new"
        expect(page).to have_selector('form')
        expect(page).to have_field("item_name")
        expect(page).to have_field("item_description")
        expect(page).to have_field("item_unit_price")
      end

      it "I am taken to a form that allows me to add item information" do 
        visit "/merchants/#{@merchant1.id}/items"
        
        expect(page).to_not have_content("medicine- 3467typeadvil")

        visit "/merchants/#{@merchant1.id}/items/new"

        fill_in "item_name", with: "medicine- 3467typeadvil"
        fill_in "item_description", with: "advil"
        fill_in "item_unit_price", with: 1200

        click_button("Create Item")


        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
        expect(page).to have_content("medicine- 3467typeadvil")
      end
    end
  end 
end 