require 'rails_helper'

RSpec.describe 'Admin Merchants Index', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
  end
  describe "Admin Merchant Index Page (User Story 24)" do
    it "displays each merchant in system" do
      visit admin_merchants_path
      expect(page).to have_content("Admin Merchants Index")
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
    end
  end

  describe "Admin Merchant Show (User Story 25)" do
    it "Each merchant name is a link that takes you to their admin show page and it shows their name" do
      visit admin_merchants_path
      click_link(@merchant_1.name)
      expect(current_path).to eq(admin_merchant_path(@merchant_1))
      expect(page).to have_content(@merchant_1.name)

      expect(page).to_not have_content(@merchant_2.name)
      expect(page).to_not have_content(@merchant_3.name)


      visit admin_merchants_path
      click_link(@merchant_2.name)
      expect(current_path).to eq(admin_merchant_path(@merchant_2))
      expect(page).to have_content(@merchant_2.name)

      expect(page).to_not have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_3.name)

      visit admin_merchants_path
      click_link(@merchant_3.name)
      expect(page).to have_current_path(admin_merchant_path(@merchant_3))
      expect(page).to have_content(@merchant_3.name)

      expect(page).to_not have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
    end
  end

  describe "Admin Merchant Create (User Story 29)" do
    it "displays link, create new merchant, and clicking redirects to new merchant form" do
      visit admin_merchants_path
      expect(page).to_not have_content("Test Merchant 1")

      expect(page).to have_link("Create New Merchant")
      click_link("Create New Merchant")
      expect(page).to have_current_path(new_admin_merchant_path)
      expect(page).to have_field('name')
      expect(page).to have_button('Submit')

    end

    it "filling information and submitting redirects to admin merchant index page" do
      visit new_admin_merchant_path
      fill_in 'name', with: 'Test Merchant 1'
      click_button('Submit')
      expect(page).to have_current_path(admin_merchants_path)
      expect(page).to have_content("New merchant has been successfully created")
    end

    it "failing to fill the form displays error message" do
      visit new_admin_merchant_path
      fill_in 'name', with: ''
      click_button('Submit')
      expect(page).to have_current_path(new_admin_merchant_path)
      expect(page).to have_content("Error: Name can't be blank")
    end

    xit "new merchant is displayed with a status of disabled" do
      visit admin_merchants_path
      expect(page).to have_content('Test Merchant 1 Status: Disabled')

    end
    
  end
end