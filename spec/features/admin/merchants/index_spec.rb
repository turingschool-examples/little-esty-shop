require "rails_helper"

RSpec.describe "admin/merchants index page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Marvel", status: 'enabled')
    @merchant_2 = Merchant.create!(name: "D.C.", status: 'disabled')
    @merchant_3 = Merchant.create!(name: "Darkhorse", status: 'enabled')
    @merchant_4 = Merchant.create!(name: "Image", status: 'disabled')
  end
  # US 24 As an admin,
  # When I visit the admin merchants index (/admin/merchants)
  # Then I see the name of each merchant in the system
  describe 'when i visit the merchant index I see a name for each merchant'do
    it "shows the name of each merchant" do
      visit "/admin/merchants"

      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      expect(page).to have_content(@merchant_4.name)
    end

    it "each name links to an merchants' show page" do
      visit "/admin/merchants"

      expect(page).to have_link(@merchant_1.name)
      expect(page).to have_link(@merchant_2.name)
      expect(page).to have_link(@merchant_3.name)
      expect(page).to have_link(@merchant_4.name)
  
      click_on "#{@merchant_1.name}"
      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    end
  end

  #US 27 As an admin,
  # When I visit the admin merchants index
  # Then next to each merchant name I see a button to disable or enable that merchant.
  # When I click this button
  # Then I am redirected back to the admin merchants index
  # And I see that the merchant's status has changed
  describe 'as an admin I see a button to update a merchants status' do 
    it 'has a buttons next to each merchant to enable or disable' do
      visit "/admin/merchants"
      
      within("#merchant-#{@merchant_1.id}") do 
        expect(page).to have_content(@merchant_1.name)
        expect(page).to_not have_button("Enable")
        expect(page).to have_button("Disable")
      end

      within("#merchant-#{@merchant_2.id}") do 
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_button("Enable")
        expect(page).to_not have_button("Disable")
      end

      within("#merchant-#{@merchant_3.id}") do 
        expect(page).to have_content(@merchant_3.name)
        expect(page).to_not have_button("Enable")
        expect(page).to have_button("Disable")
      end

      within("#merchant-#{@merchant_4.id}") do 
        expect(page).to have_content(@merchant_4.name)
        expect(page).to have_button("Enable")
        expect(page).to_not have_button("Disable")
      end
    end
  end
end