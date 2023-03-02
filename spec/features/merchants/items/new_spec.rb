require 'rails_helper'

RSpec.describe "Merchant_Items#New", type: :feature do
  before(:each) do
    @merchant = create(:merchant, name: "Trader Bob's")

    contributors_json_response = File.open("./fixtures/contributors.json")
    pulls_json_response = File.open("./fixtures/pulls.json")
    repo_json_response = File.open("./fixtures/repo.json")

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop").
      to_return(status: 200, body: repo_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/pulls?state=closed").
      to_return(status: 200, body: pulls_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/contributors").
      to_return(status: 200, body: contributors_json_response)


    visit "/merchants/#{@merchant.id}/items/new"
  end

  describe "User Story 11" do
    context "As a merchant when I visit my items index page" do 
      it "I see a form that allows me to add item information" do
        
        expect(page).to have_content("Add a New Item")
        expect(find('form')).to have_content("Name")
        expect(find('form')).to have_content("Description")
        expect(find('form')).to have_content("Unit price")
      end
      
      it "When I fill out the form I click Submit then I am taken back to the items index page" do
        
        fill_in "Name", with: "Super Mario"
        fill_in "Description", with: "It's a video game!"
        fill_in "Unit price", with: 40
        click_button "Create Item"
        
        expect(current_path).to eq("/merchants/#{@merchant.id}/items")
      end

      it "When I don't fill out the form I click Submit then I do not leave the create page and see an error message" do
        
        fill_in "Name", with: ""
        fill_in "Description", with: ""
        fill_in "Unit price", with: ""
        click_button "Create Item"
        
        expect(current_path).to eq("/merchants/#{@merchant.id}/items/new")
        expect(page).to have_content("Missing Information! Cannot be Created!")
      end
    end
  end
end