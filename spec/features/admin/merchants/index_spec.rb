require 'rails_helper'

RSpec.describe '#index' do
  describe 'as an admin when I visit the admin merchants index page' do

    before :each do
      @merchant1 = Merchant.create!(name: "Carlos Jenkins") 
      @merchant2 = Merchant.create!(name: "Leroy Jenkins") 
      @merchant3 = Merchant.create!(name: "Melissa Jenkins") 
      @merchant4 = Merchant.create!(name: "Jenny Jenkins") 
      @merchant5 = Merchant.create!(name: "Mickey Mantle") 
      visit admin_merchants_path
    end

    it 'I see the names of each merchant in the system' do
      expect(page).to have_content("Carlos Jenkins")
      expect(page).to have_content("Leroy Jenkins")
      expect(page).to have_content("Melissa Jenkins")
      expect(page).to have_content("Jenny Jenkins")
      expect(page).to have_content("Mickey Mantle")
    end

    it 'the names of each merchant are links to their admin show page' do
      expect(page).to have_link("Carlos Jenkins")
      expect(page).to have_link("Leroy Jenkins")
      expect(page).to have_link("Melissa Jenkins")
      expect(page).to have_link("Jenny Jenkins")
      expect(page).to have_link("Mickey Mantle")

      click_link "Carlos Jenkins"

      expect(current_path).to eq "/admin/merchants/#{@merchant1.id}"
    end

    it 'I see a button to enable or disable merchants next to their name' do
      
      within "#id-#{@merchant1.id}" do
        expect(page).to have_button("Enable")
        click_button "Enable"
        expect(current_path).to eq admin_merchants_path
        expect(page).to have_button("Disable")
      end

      within "#id-#{@merchant2.id}" do
        expect(page).to have_button("Enable")
        click_button "Enable"
        expect(current_path).to eq admin_merchants_path
        expect(page).to have_button("Disable")
      end
    end

    it 'I see a section for "enabled merchants" and "disabled merchants"' do
      expect(page).to have_content("Enabled Merchants")
      expect(page).to have_content("Disabled Merchants")
    end
    
    it 'I see a link to create a new merchant' do
      expect(page).to have_link "Create New Merchant"
      expect(page).to_not have_content("Newest Merchant")
  
      click_link "Create New Merchant"
      expect(current_path).to eq '/merchants/new'
  
      fill_in "Name", with: "Newest Merchant"
      click_button "Create Merchant"
  
      expect(current_path).to eq admin_merchants_path
      expect(page).to have_content("Newest Merchant")
    end


    it 'I see the date with the most revenue for each merchant' do
      load_test_data
      visit "/admin/merchants"
      
      within '#top-5-merchants' do
        within "#id-#{@merchant1.id}" do
          expect(page).to have_content("Top selling date for #{@merchant1.name} was Tuesday, February 28, 2023")
        end
      end
    end

  
    it 'I see a section listing the top 5 merchants by revenue and their total revenue' do
      load_test_data
      visit "/admin/merchants"
      
      within "#top-5-merchants" do
      
        expect(page).to have_content("Top 5 Merchants by Revenue")
        expect(page).to have_content "Melissa Jenkins -- Total Revenue: $66414"
        expect("Melissa Jenkins").to appear_before("Mickey Mantle")
        expect("Mickey Mantle").to appear_before("Human who sells stuff")
        expect("Human who sells stuff").to appear_before("Carlos Jenkins")
        expect("Carlos Jenkins").to appear_before("Jenny Jenkins")
      end
    end
  end
end