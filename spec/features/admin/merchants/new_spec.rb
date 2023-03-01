require 'rails_helper'

RSpec.describe "admin merchants new", type: :feature do

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

    @merchant_1 = Merchant.create!(name: "Mel's Travels", uuid: 1)
    @merchant_3 = Merchant.create!(name: "Huy's Cheese", uuid: 3)
    @merchant_2 = Merchant.create!(name: "Hady's Beach Shack", uuid: 2)

  end

  describe 'as an admin' do
    describe "visit the admin merchants new page" do 
      it "there is a form that allows me to add merchant information" do 
        visit new_admin_merchant_path

        expect(page).to have_selector('form')
        expect(page).to have_field("Name")
        expect(page).to have_button("Create Merchant")
      end 

        it "i fill in the form and click submit and am taken back to the admin merchants index page and can see the merchant we just created which as a default status of zero" do 

          visit admin_merchants_path

          expect(page).to_not have_content("Diego")

          visit new_admin_merchant_path

          fill_in "Name", with: "Diego"

          click_button("Create Merchant")

          expect(current_path).to eq(admin_merchants_path)

          expect(page).to have_content("Diego")

          expect(Merchant.last.status).to eq("disabled")

        end 

      end
    end
  end