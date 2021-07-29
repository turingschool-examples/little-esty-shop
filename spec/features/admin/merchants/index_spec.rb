require 'rails_helper'

RSpec.describe 'Admin::Merchants' do

  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @merchant5 = create(:merchant, enabled: false)

    visit '/admin/merchants'
  end

  describe 'Admin Invoices Index Page' do

    it 'displays the name of each merchant in the systems' do

      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_content(@merchant3.name)
      expect(page).to have_content(@merchant4.name)
      expect(page).to have_content(@merchant5.name)
    end
  end

  describe 'Link to Merchant Show page' do
    it 'when clicking the name of the merchant, visitor is redirected to merchant show page' do
      expect(page).to have_link(@merchant1.name)
      expect(page).to have_link(@merchant2.name)
      expect(page).to have_link(@merchant3.name)
      expect(page).to have_link(@merchant4.name)
      expect(page).to have_link(@merchant5.name)

      click_on @merchant1.name

      expect(current_path).to eq(admin_merchant_path(@merchant1.id))
    end
  end

  describe 'Merchant Enable Button' do
    it 'has a button to disable/enable each merchant' do
      expect(page).to have_button("Disable #{@merchant1.name}")
      expect(page).to have_button("Enable #{@merchant5.name}")

      click_on "Enable #{@merchant5.name}"

      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_button("Disable #{@merchant5.name}")
    end
  end

  describe 'group by status' do
    it 'page shows 2 sections enabled merchants and diabled merchants' do

      within('#green') do
        expect(page).to have_content("Enabled Merchants")
      end

      within('#red')
        expect(page).to have_content("Disabled Merchants")
      end
  end

  describe 'Admin Merchant Create' do
    #     Admin Merchant Create

    # As an admin,
    # When I visit the admin merchants index
    # I see a link to create a new merchant.
    # When I click on the link,
    # I am taken to a form that allows me to add merchant information.
    # When I fill out the form I click ‘Submit’
    # Then I am taken back to the admin merchants index page
    # And I see the merchant I just created displayed
    # And I see my merchant was created with a default status of disabled.
    it 'has a link to create a new Merchant' do

      expect(page).to have_link('Create Merchant')

      click_link 'Create Merchant'

      expect(current_path).to eq(new_admin_merchant_path)

      fill_in 'Name', with: "Darry 'Big J' Johnson" 
      click_on 'Submit'

      expect(current_path).to eq(admin_merchants_path)

      expect(page).to have_content("Darry 'Big J' Johnson")
      
      within('#red')
        expect(page).to have_content("Disable Darry 'Big J' Johnson")
      end
    end
  end
