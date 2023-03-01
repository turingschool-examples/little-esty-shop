require 'rails_helper'

RSpec.describe "admin merchants edit", type: :feature do

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

    commits_call = File.read('spec/fixtures/commits_call.json')
    stub_request(:get, 'https://api.github.com/repos/hadyematar23/little-esty-shop/stats/contributors')
    .with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>"Bearer #{ENV['github_token']}",
        'User-Agent'=>'Faraday v2.7.4'
         }
    )
    .to_return(status: 200, body: commits_call, headers: {})
  
    end

  describe 'merchant edit' do
    it 'links to a merchant edit page' do
      @merchant_1 = Merchant.create!(name: "Mel's Travels")
      visit "/admin/merchants/#{@merchant_1.id}"
  
      click_on("Update #{@merchant_1.name}")

      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")

      fill_in "Name", with: "Merchanty Merchant"
      
      click_on("Update")
      
      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
      expect(page).to have_content("Merchanty Merchant")
    end
  end
end