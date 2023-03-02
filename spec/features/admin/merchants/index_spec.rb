require 'rails_helper'
RSpec.describe "Admin Merchants Index", type: :feature do 
  let!(:bob) { Merchant.create!(name: "Bob's Beauties", status: 0) } 
  let!(:rob) { Merchant.create!(name: "Rob's Rarities") } 
  let!(:hob) { Merchant.create!(name: "Hob's Hoootenanies", status: 0) } 
  let!(:dob) { Merchant.create!(name: "Dob's Dineries") } 
  let!(:zob) { Merchant.create!(name: "7-11") }

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

  describe "As an admin" do
    context "When I visit the admin merchants index (/admin/merchants)" do
      before do
        visit admin_merchants_path
      end

      it "Sees the name of each merchant in the system" do
        expect(page).to have_content("Bob's Beauties")
        expect(page).to have_content("#{bob.name}")

        expect(page).to have_content("Rob's Rarities")
        expect(page).to have_content("#{rob.name}")

        expect(page).to have_content("Hob's Hoootenanies")
        expect(page).to have_content("#{hob.name}")

        expect(page).to have_content("Dob's Dineries")
        expect(page).to have_content("#{dob.name}")

        expect(page).to have_content("7-11")
        expect(page).to have_content("#{zob.name}")
      end
      
      it 'next to each merchant I see a button to disable or enable that merchant' do
        within "div#enabled_merchant-#{bob.id}" do
          expect(page).to have_button('Disable')
        end
        within "div#enabled_merchant-#{hob.id}" do
          expect(page).to have_button('Disable')
        end
        within "div#disabled_merchant-#{rob.id}" do
          expect(page).to have_button('Enable')
        end
        within "div#disabled_merchant-#{dob.id}" do
          expect(page).to have_button('Enable')
        end
        within "div#disabled_merchant-#{zob.id}" do
          expect(page).to have_button('Enable')
        end
      end

      it 'displays enabled merchants in the enabled merchants section' do
         
        within "div#enabled_merchant-#{bob.id}" do
          expect(page).to have_content(bob.name)
        end

        within "div#enabled_merchant-#{hob.id}" do
          expect(page).to have_content(hob.name)
        end

      end

      it 'displays the disabled merchants in the disabled marchants section' do
        within "div#disabled_merchant-#{rob.id}" do
          expect(page).to have_content(rob.name)
        end

        within "div#disabled_merchant-#{dob.id}" do
          expect(page).to have_content(dob.name)
        end

        within "div#disabled_merchant-#{zob.id}" do
          expect(page).to have_content(zob.name)
        end
      end

      it 'changes the status of the item after the button click' do
        
        within "div#enabled_merchant-#{bob.id}" do
          click_button 'Disable'
          bob.reload
          expect(bob.status).to eq('disabled')
          expect(current_path).to eq(admin_merchants_path)
        end
        
        within "div#enabled_merchant-#{hob.id}" do
          click_button 'Disable'
          hob.reload
          expect(hob.status).to eq('disabled')
          expect(current_path).to eq(admin_merchants_path)
        end

        within "div#disabled_merchant-#{rob.id}" do
          click_button 'Enable'
          rob.reload
          expect(rob.status).to eq('enabled')
          expect(current_path).to eq(admin_merchants_path)
        end

        within "div#disabled_merchant-#{dob.id}" do
          click_button 'Enable'
          dob.reload
          expect(dob.status).to eq('enabled')
          expect(current_path).to eq(admin_merchants_path)
        end

        within "div#disabled_merchant-#{zob.id}" do
          click_button 'Enable'
          zob.reload
          expect(zob.status).to eq('enabled')
          expect(current_path).to eq(admin_merchants_path)
        end
      end
    end
  end
end