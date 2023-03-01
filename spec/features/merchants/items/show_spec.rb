require 'rails_helper'

RSpec.describe 'show', type: :feature do
  
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
  end
  describe "when merchant visit /merchants/merchant_id/items" do
    let!(:schroeder_jerde) { Merchant.create!(name: 'Schroeder-Jerde')}
    let!(:qui) {Item.create!(merchant: schroeder_jerde, name: 'Qui Esse', unit_price: 75107, description: "Cooling") }
    let!(:autem) {Item.create!(merchant: schroeder_jerde, name: 'Autem Minima', unit_price: 67076, description: "Sweet") }
    let!(:ea) {Item.create!(merchant: schroeder_jerde, name: 'Ea Voluptatum', unit_price: 32301, description: "Soft")}

    it 'should see all attributes of the items' do
      visit "/merchants/#{schroeder_jerde.id}/items"
      click_link("#{qui.name}")
      expect(current_path).to eq("/merchants/#{schroeder_jerde.id}/items/#{qui.id}")
      expect(page).to have_content("Name: #{qui.name}")
      expect(page).to have_content("Description: #{qui.description}")
      expect(page).to have_content("Unit Price: #{qui.unit_price}")
    end

    it 'have form to update and edit the item' do
      visit "/merchants/#{schroeder_jerde.id}/items/#{qui.id}"

      within "#item-#{qui.id}" do
        expect(page).to have_link("Edit Item", href: "/merchants/#{schroeder_jerde.id}/items/#{qui.id}/edit")
        click_link("Edit Item")
      end
      expect(current_path).to eq("/merchants/#{schroeder_jerde.id}/items/#{qui.id}/edit")
    end
  end
end