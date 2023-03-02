require 'rails_helper'

RSpec.describe 'Merchant Items', type: :feature do
  describe 'Merchant Items Show' do

    let!(:sam) { Merchant.create!(name: "Sam's Sports") }
    let!(:football) { sam.items.create!(name: "Football", description: "This a football", unit_price: 3000) }
    let!(:baseball) { sam.items.create!(name: "Baseball", description: "This a baseball", unit_price: 2500) }
    let!(:glove) { sam.items.create!(name: "Baseball Glove", description: "This a baseball glove", unit_price: 4000) }

    before :each do
      repo_call = File.read('spec/fixtures/repo_call.json')
      collaborators_call = File.read('spec/fixtures/collaborators_call.json')
      pulls_call = File.read('spec/fixtures/pulls_call.json')

      stub_request(:get, "https://api.github.com/repos/4D-Coder/little-esty-shop").
          with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"Bearer #{ENV["github_token"]}",
            'User-Agent'=>'Faraday v2.7.4'
            }).
          to_return(status: 200, body: repo_call, headers: {})


      stub_request(:get, "https://api.github.com/repos/4D-Coder/little-esty-shop/assignees").
          with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"Bearer #{ENV["github_token"]}",
            'User-Agent'=>'Faraday v2.7.4'
            }).
          to_return(status: 200, body: collaborators_call, headers: {})

      stub_request(:get, "https://api.github.com/repos/4D-Coder/little-esty-shop/pulls?state=all&merged_at&per_page=100").
          with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"Bearer #{ENV["github_token"]}",
            'User-Agent'=>'Faraday v2.7.4'
            }).
          to_return(status: 200, body: pulls_call, headers: {})
    end

    describe 'As a merchant' do 
      context "When I visit my merchant's item's show page" do
        it 'I see the item name and all of its attributes' do
          visit merchant_item_path(sam.id, football.id)
          
          expect(page).to have_content(football.name)

          within 'div#item_attributes' do
            expect(page).to have_content("Description: #{football.description}")
            expect(page).to have_content("Current Selling Price: $30.00")
            expect(page).to have_content("Current Selling Price: $#{football.unit_price / 100}")
          end
        end
      end
    end
  end
end