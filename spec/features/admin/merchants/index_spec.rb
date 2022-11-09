require 'rails_helper'

RSpec.describe "Admin Merchant Index", type: :feature do
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

      within "#merchant-enabled" do
        expect(page).to have_button("Disable Crystal Moon Designs")
        expect(page).to have_content("This storefront is currently: OPEN")

        click_button "Disable Crystal Moon Designs"
      end

      within "#merchant-disabled" do
        expect(current_path).to eq(admin_merchants_path)

        expect(page).to have_button("Enable Crystal Moon Designs")
        expect(page).to have_content("This storefront is currently: CLOSED")

        click_button "Enable Crystal Moon Designs"
      end

      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content("This storefront is currently: OPEN")
    end

    it 'has two sections, one for enabled merchants and one for disabled merchants.
    I see that each merchant is listed in the appropriate section' do
      visit admin_merchants_path

      within "#merchant-enabled" do
        expect(page).to have_content("#{@merchant_1.name}")
        expect(page).to have_content("#{@merchant_2.name}")
        expect(page).to have_content("#{@merchant_3.name}")
      end

      within "#merchant-disabled" do
        expect(page).to_not have_content("#{@merchant_1.name}")
        expect(page).to_not have_content("#{@merchant_2.name}")
        expect(page).to_not have_content("#{@merchant_3.name}")
      end

      click_button "Disable Crystal Moon Designs"

      within "#merchant-enabled" do
        expect(page).to have_content("#{@merchant_2.name}")
        expect(page).to have_content("#{@merchant_3.name}")
        expect(page).to_not have_content("#{@merchant_1.name}")
      end

      within "#merchant-disabled" do
        expect(page).to have_content("#{@merchant_1.name}")
        expect(page).to_not have_content("#{@merchant_2.name}")
        expect(page).to_not have_content("#{@merchant_3.name}")
      end

      click_button "Disable Outer Outfitters"

      within "#merchant-enabled" do
        expect(page).to have_content("#{@merchant_2.name}")
        expect(page).to_not have_content("#{@merchant_1.name}")
        expect(page).to_not have_content("#{@merchant_3.name}")
      end

      within "#merchant-disabled" do
        expect(page).to have_content("#{@merchant_1.name}")
        expect(page).to_not have_content("#{@merchant_2.name}")
        expect(page).to have_content("#{@merchant_3.name}")
      end

      click_button "Enable Crystal Moon Designs"

      within "#merchant-enabled" do
        expect(page).to have_content("#{@merchant_1.name}")
        expect(page).to have_content("#{@merchant_2.name}")
        expect(page).to_not have_content("#{@merchant_3.name}")
      end

      within "#merchant-disabled" do
        expect(page).to have_content("#{@merchant_3.name}")
        expect(page).to_not have_content("#{@merchant_1.name}")
        expect(page).to_not have_content("#{@merchant_2.name}")
      end
    end
  end
end
