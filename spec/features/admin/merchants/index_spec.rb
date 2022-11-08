require 'rails_helper'

RSpec.feature "Admin Merchant Index", type: :feature do
  describe 'when visiting the page' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Crystal Moon Designs")
      @merchant_2 = Merchant.create!(name: "Surf & Co. Designs")
      @merchant_3 = Merchant.create!(name: "Outer Outfitters")
    end

    it 'has the name of each merchant in the system' do
      visit admin_merchants_path

      expect(page).to have_content("Crystal Moon Designs")
      expect(page).to have_content("Surf & Co. Designs")
      expect(page).to have_content("Outer Outfitters")
    end

    it 'next to each merchant name, I see a button to disable or enable that merchant.
    when I click this button, I am redirected back to the admin merchants index and
    I see that the merchants status has changed' do
      visit admin_merchants_path
    save_and_open_page

      within "#merchants-#{@merchant_1.id}" do
        expect(page).to have_button("Disable Crystal Moon Designs")
        expect(page).to have_content("This storefront is currently: OPEN")

        click_button "Disable Crystal Moon Designs"
        expect(current_path).to eq(admin_merchants_path)

        expect(page).to have_button("Enable Crystal Moon Designs")
        expect(page).to have_content("This storefront is currently: CLOSED")

        click_button "Enable Crystal Moon Designs"
        expect(current_path).to eq(admin_merchants_path)

        expect(page).to have_content("This storefront is currently: OPEN")
      end
    end

    it 'has two sections, one for enabled merchants and one for disabled merchants.
    I see that each merchant is listed in the appropriate section' do
      visit admin_merchants_path

      within "#enabled" do
        expect(page).to have_content("#{@merchant_1.name}")
        expect(page).to have_content("#{@merchant_2.name}")
        expect(page).to have_content("#{@merchant_3.name}")
      end
      
      within "#disabled" do
        expect(page).to_not have_content("#{@merchant_1.name}")
        expect(page).to_not have_content("#{@merchant_2.name}")
        expect(page).to_not have_content("#{@merchant_3.name}")
      end

      click_button "Disable Crystal Moon Designs"

      within "#enabled" do
        expect(page).to_not have_content("#{@merchant_1.name}")
        expect(page).to have_content("#{@merchant_2.name}")
        expect(page).to have_content("#{@merchant_3.name}")
      end
      
      within "#disabled" do
        expect(page).to have_content("#{@merchant_1.name}")
        expect(page).to_not have_content("#{@merchant_2.name}")
        expect(page).to_not have_content("#{@merchant_3.name}")
      end

      click_button "Disable Outer Outfitters"

      within "#enabled" do
        expect(page).to_not have_content("#{@merchant_1.name}")
        expect(page).to have_content("#{@merchant_2.name}")
        expect(page).to_not have_content("#{@merchant_3.name}")
      end
    
      within "#disabled" do
        expect(page).to have_content("#{@merchant_1.name}")
        expect(page).to_not have_content("#{@merchant_2.name}")
        expect(page).to have_content("#{@merchant_3.name}")
      end

      click_button "Enable Crystal Moon Designs"

      within "#enabled" do
        expect(page).to have_content("#{@merchant_1.name}")
        expect(page).to have_content("#{@merchant_2.name}")
        expect(page).to_not have_content("#{@merchant_3.name}")
      end
    
      within "#disabled" do
        expect(page).to_not have_content("#{@merchant_1.name}")
        expect(page).to_not have_content("#{@merchant_2.name}")
        expect(page).to have_content("#{@merchant_3.name}")
      end
    end
  end
end
