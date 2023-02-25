require 'rails_helper'

RSpec.describe 'merchant items index page', type: :feature do
  describe "as a merchant, when I visit my merchant index page ('/merchant/merchant_id/items')" do
    let!(:merchant1) { create(:merchant)}
    let!(:merchant2) { create(:merchant)}

    let!(:item1) {create(:item, merchant: merchant1)}  
    let!(:item2) {create(:item, merchant: merchant1, status: 'enabled')}
    let!(:item3) {create(:item, merchant: merchant1)}
    let!(:item4) {create(:item, merchant: merchant1)}
    let!(:item5) {create(:item, merchant: merchant2)}

    it "I see a list of the names of all the items and do not see other merchant items" do
      visit "/merchants/#{merchant1.id}/items"

      expect(page).to have_content(item1.name)
      expect(page).to have_content(item2.name)
      expect(page).to have_content(item3.name)
      expect(page).to have_content(item4.name)

      expect(page).to_not have_content(item5.name)
    end

    it 'has a buttom next to each item to disable or enable that item' do
      visit "/merchants/#{merchant1.id}/items"

      within "##{item1.id}" do 
        expect(page).to have_content(item1.name)
        expect(page).to have_button("Enable")
      end

      within "##{item2.id}" do 
        expect(page).to have_content(item2.name)
        expect(page).to have_button("Disable")
      end
    end

    it 'changes the status when I click the buttom and redirects back to items index' do
      visit "/merchants/#{merchant1.id}/items"

      within "##{item1.id}" do 
        expect(page).to have_button("Enable")

        click_button

        expect(page).to have_button("Disable")
      end
    end
		
		describe 'enable/disabled sections on page' do
			it 'seperate enabled section' do
				visit merchant_items_path(merchant1)

				within "#enabled_items" do
					expect(page).to have_content(item2.name)
					expect(page).to_not have_content(item1.name)
					expect(page).to_not have_content(item3.name)
					expect(page).to_not have_content(item4.name)
					expect(page).to_not have_content(item5.name)
					
					within "##{item2.id}" do 
						click_button
					end
					
					expect(page).to_not have_content(item2.name)
				end
			end

			it 'seperate disabled section' do
				visit merchant_items_path(merchant1)
				
				within "#disabled_items" do
					expect(page).to_not have_content(item2.name)
					expect(page).to have_content(item1.name)
					expect(page).to have_content(item3.name)
					expect(page).to have_content(item4.name)
					
					within "##{item3.id}" do 
						click_button
					end

					expect(page).to_not have_content(item3.name)
				end
			end
		end
  end
end