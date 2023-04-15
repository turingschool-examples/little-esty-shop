require 'rails_helper'

RSpec.describe 'Admin Merchants Index', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant, is_enabled: true) #enabled to start
    @merchant_2 = create(:merchant, is_enabled: true) #enabled to start
    @merchant_3 = create(:merchant) #disabled to start (is_enabled: false by default)
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
      expect(page).to have_current_path(new_merchant_path)
      expect(page).to have_field('merchant_name')
      expect(page).to have_button('Submit')

    end

    it "filling information and submitting redirects to admin merchant index page" do
      visit new_merchant_path
      fill_in 'merchant_name', with: 'Test Merchant 1'
      click_button('Submit')
      expect(page).to have_current_path(admin_merchants_path)
      expect(page).to have_content("New merchant has been successfully created")
    end

    it "failing to fill the form displays error message" do
      visit new_merchant_path
      fill_in 'merchant_name', with: ''
      click_button('Submit')
      expect(page).to have_current_path(new_merchant_path)
      expect(page).to have_content("Error: Name can't be blank")
    end

    it "new merchant is displayed with a status of disabled" do
      visit new_merchant_path
      fill_in 'merchant_name', with: 'Test Merchant 1'
      click_button('Submit')
      expect(page).to have_content('Test Merchant 1 Status: Disabled')
    end
  end


  describe "Admin Merchant Enable / Disable (User Story 27)" do
    it 'shows a button to either enable or disable a merchant, based on their current activity status' do
      visit admin_merchants_path

      within ("#merchant-#{@merchant_1.id}") do
        expect(page).to have_button("Disable")
      end

      within ("#merchant-#{@merchant_2.id}") do
        expect(page).to have_button("Disable")
      end

      within ("#merchant-#{@merchant_3.id}") do
        expect(page).to have_button("Enable")
      end
    end

    it 'updates the activity status of the given merchant when clicked, and returns admin merchant index' do
      visit admin_merchants_path

      expect(@merchant_1.is_enabled).to be(true)
      expect(@merchant_2.is_enabled).to be(true)
      expect(@merchant_3.is_enabled).to be(false)

      within ("#merchant-#{@merchant_1.id}") do
        click_button("Disable")
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_button("Enable")
      end

      within ("#merchant-#{@merchant_2.id}") do
        click_button("Disable")
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_button("Enable")
      end

      within ("#merchant-#{@merchant_3.id}") do
        click_button("Enable")
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_button("Disable")
      end

      expect(@merchant_1.reload.is_enabled).to be(false)
      expect(@merchant_2.reload.is_enabled).to be(false)
      expect(@merchant_3.reload.is_enabled).to be(true)
    end
  end

end