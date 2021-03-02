require 'rails_helper'

RSpec.describe 'Admin/merchant index' do
  describe 'When I visit the admin/merchant index (/admin/merchant)' do
    before (:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant, status: 1)
      @merchant_4 = create(:merchant)
      @merchant_5 = create(:merchant)
      @merchant_6 = create(:merchant)
      @merchant_7 = create(:merchant)
      @merchant_8 = create(:merchant)
      @merchant_9 = create(:merchant)
      @merchant_10 = create(:merchant)
      @merchant_11 = create(:merchant)
      @merchant_12 = create(:merchant)
    end
    it 'Then I see the name of each merchant in the system' do
      visit "/admin/merchants"

      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content("#{@merchant_1.name}")
      expect(page).to have_content("#{@merchant_2.name}")
      expect(page).to have_content("#{@merchant_3.name}")
      expect(page).to have_content("#{@merchant_4.name}")
      expect(page).to have_content("#{@merchant_5.name}")
      expect(page).to have_content("#{@merchant_6.name}")
      expect(page).to have_content("#{@merchant_7.name}")
    end

    it 'Then next to each merchant name I see a button to disable or enable that merchant.' do
      visit "/admin/merchants"

      expect(current_path).to eq('/admin/merchants')

      within("#merchant-#{@merchant_1.id}") do
        expect(page).to have_button("disable")
        expect(page).to have_content("#{@merchant_1.status}")
      end

      within("#merchant-#{@merchant_3.id}") do
        expect(page).to have_button("enable")
        expect(page).to have_content("#{@merchant_3.status}")
      end
    end

    it 'When I click this button I am redirected back to the admin merchants index and I see the new status' do
      visit "/admin/merchants"

      expect(current_path).to eq('/admin/merchants')

      within("#merchant-#{@merchant_1.id}") do
        expect(page).to have_button("disable")
        expect(page).to have_content("#{@merchant_1.status}")

        click_button("disable")

        expect(current_path).to eq('/admin/merchants')
        expect(page).to have_content("disabled")
      end

      within("#merchant-#{@merchant_3.id}") do
        expect(page).to have_button("enable")
        expect(page).to have_content("#{@merchant_3.status}")

        click_button("enable")

        expect(current_path).to eq('/admin/merchants')
        expect(page).to have_content("enabled")
      end
    end

    it 'I see a link to create a new merchant' do
      visit "/admin/merchants"

      expect(page).to have_link("New Merchant")
    end

    it "Displays two sections for 'Enabled Merchants' and 'Disabled Merchants'" do
      visit "/admin/merchants"

      expect(page).to have_content("Enabled Merchants")
      expect(page).to have_content("Disabled Merchants")
    end

    it 'And I see that each Merchant is listed in the appropriate section' do
      Merchant.destroy_all
      merchant_1 = create(:merchant, status: 0)
      merchant_2 = create(:merchant, status: 1)
      merchant_3 = create(:merchant, status: 1)
      merchant_4 = create(:merchant, status: 1)
      merchant_5 = create(:merchant, status: 0)
      visit "/admin/merchants"

      within("#enabled-merchants") do
        expect(page).to have_content("#{merchant_1.name}")
        expect(page).to have_content("#{merchant_5.name}")
      end

      within("#disabled-merchants") do
        expect(page).to have_content("#{merchant_2.name}")
        expect(page).to have_content("#{merchant_3.name}")
        expect(page).to have_content("#{merchant_4.name}")
      end
    end
  end
end
