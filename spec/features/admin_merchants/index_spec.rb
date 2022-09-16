require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bread Pitt")
    @merchant_2 = Merchant.create!(name: "Carrie Breadshaw")
    @merchant_3 = Merchant.create!(name: "Sheena Yeaston")
    @merchant_4 = Merchant.create!(name: "Taylor Sift")
  end

  describe 'US6' do
    it 'shows the name of all the merchants in the system' do
      visit "/admin/merchants"

      expect(page).to have_content("Bread Pitt")
      expect(page).to have_content("Carrie Breadshaw")
      expect(page).to have_content("Sheena Yeaston")
      expect(page).to have_content("Taylor Sift")
      expect(page).to_not have_content("Meat Loaf") #customer name
    end
  end

  describe 'US7' do
    it 'has a link on each merchants name taking you to their individual show page with their name' do
      visit "/admin/merchants"
      click_link "#{@merchant_1.name}"

      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
      expect(page).to have_content("Bread Pitt")
      expect(page).to_not have_content("Carrie Breadshaw")
    end
  end

  describe 'US9' do
    it 'can disable merchants' do
       # As an admin,
      # When I visit the admin merchants index
      visit "/admin/merchants"
      # Then next to each merchant name I see a button to disable or enable that merchant.
      within("#enabled_merchant-#{@merchant_1.id}") do
        expect(page).to have_button("Disable")
        # click_button("Disable")
        click_button("Disable")
        # Then I am redirected back to the admin merchants index
        expect(current_path).to eq("/admin/merchants")
      end

      within("#disabled_merchant-#{@merchant_1.id}") do
        # And I see that the merchant's status has changed
        expect(page).to have_button("Enable")
      end
    end

    it 'can enable merchants' do
      yeasty = Merchant.create!(name: "The Yeasty Boys", status: :Disabled)

      visit "/admin/merchants"

      within("#disabled_merchant-#{yeasty.id}") do
        expect(page).to have_button("Enable")
        click_button("Enable")
        expect(current_path).to eq("/admin/merchants")
      end

      within("#enabled_merchant-#{yeasty.id}") do
        expect(page).to have_button("Disable")
      end
   end

  end

  describe 'US10' do
    it 'can sort between currently enabled and disabled merchants' do
      Merchant.create!(name: "The Yeasty Boys", status: :Disabled)
      Merchant.create!(name: "Cake Me Home Tonight", status: :Disabled)
      Merchant.create!(name: "Bake That", status: :Enabled)
      Merchant.create!(name: "Nutty Baker", status: :Enabled)
      # As an admin,
      visit "/admin/merchants"
      # When I visit the admin merchants index
      # Then I see two sections, one for "Enabled Merchants" and one for "Disabled Merchants"
      expect(page).to have_content("Enabled Merchants")
      expect(page).to have_content("Disabled Merchants")
      # And I see that each Merchant is listed in the appropriate section
      within '.enabled' do
        expect(page).to have_content("Bake That")
        expect(page).to have_content("Nutty Baker")
        expect(page).to_not have_content("The Yeasty Boys")
      end

      within '.disabled' do
        expect(page).to have_content("The Yeasty Boys")
        expect(page).to have_content("Cake Me Home Tonight")
        expect(page).to_not have_content("Bake That")
      end
    end
  end

  describe 'US11' do
    it 'admin merchant create' do
      # As an admin,
      # When I visit the admin merchants index
      visit "/admin/merchants"
      # I see a link to create a new merchant.
      click_link("New Merchant")
      # When I click on the link,
      # I am taken to a form that allows me to add merchant information.
      expect(current_path).to eq("/admin/merchants/new")
      # When I fill out the form I click ‘Submit’
      # Then I am taken back to the admin merchants index page
      # And I see the merchant I just created displayed
      # And I see my merchant was created with a default status of disabled.
    end
  end

end
