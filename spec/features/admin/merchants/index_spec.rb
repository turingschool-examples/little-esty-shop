require 'rails_helper'
RSpec.describe "Admin Merchants Index", type: :feature do 
  let!(:bob) { Merchant.create!(name: "Bob's Beauties") } 
  let!(:rob) { Merchant.create!(name: "Rob's Rarities", status: 1) } 
  let!(:hob) { Merchant.create!(name: "Hob's Hoootenanies") } 
  let!(:dob) { Merchant.create!(name: "Dob's Dineries", status: 1) } 
  let!(:zob) { Merchant.create!(name: "7-11", status: 1) } 

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

      it 'displays enabled merchantsin the enabled merchants section' do
         
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
        save_and_open_page
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