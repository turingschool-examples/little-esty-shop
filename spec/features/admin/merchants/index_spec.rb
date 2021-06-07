require 'rails_helper'

RSpec.describe 'merchants index page', type: :feature do\

  describe 'page appearance' do
    it 'has a section that shows the names of each merchant' do
      visit '/admin/merchants'

      merchants = Merchant.all

      merchants.each do |merchant|
        expect(page).to have_content(merchant.name)
      end
    end
    it 'groups the merchants into an enables and disabled section' do
      new_merchant = Merchant.create(name: 'Big Bird', enabled: false)

      visit '/admin/merchants'

      expect(page).to have_content('Enabled Merchants')
      expect(page).to have_content('Disabled Merchants')

      within all(".admin-merchant-index").last do
        expect(page).to have_content("Big Bird")
      end

      within all(".admin-merchant-index").first do
        expect(page).to have_content("Fahey-Stiedemann")
      end
    end
    it 'tells you the top five merchants, their revenue, and best day' do
      visit '/admin/merchants'

      expect(page).to have_content('Top 5 Merchants')

      within "#top-five-merchants > tr:nth-child(2)" do
        expect(page).to have_content('Terry-Moore')
        expect(page).to have_content('$3,115,616.00')
        expect(page).to have_content('03/26/2012')
      end
      within "#top-five-merchants > tr:nth-child(3)" do
        expect(page).to have_content('Marvin Group')
        expect(page).to have_content('$3,053,663.00')
        expect(page).to have_content('03/27/2012')
      end
      within "#top-five-merchants > tr:nth-child(4)" do
        expect(page).to have_content('Pacocha-Mayer')
        expect(page).to have_content('$2,977,622.00')
        expect(page).to have_content('03/15/2012')
      end
      within "#top-five-merchants > tr:nth-child(5)" do
        expect(page).to have_content('Crona LLC')
        expect(page).to have_content('$2,887,879.00')
        expect(page).to have_content('03/07/2012')
      end
      within "#top-five-merchants > tr:nth-child(6)" do
        expect(page).to have_content('Reynolds Inc')
        expect(page).to have_content('$2,849,929.00')
        expect(page).to have_content('03/23/2012')
      end
    end
  end

  describe 'page functionality' do
    it 'each merchant name is a link to each merchants show page' do
      visit '/admin/merchants'

      click_on 'Schroeder-Jerde'

      expect(current_path).to eq '/admin/merchants/1'
    end
    it 'each merchant has a button to enable/disable it' do
      visit '/admin/merchants'

      expect(page).to have_content('Status')
      click_on 'Disable', match: :first

      expect(current_path).to eq('/admin/merchants')

      click_on 'Schroeder-Jerde'

      expect(page).to have_content('Disabled')

      visit '/admin/merchants'
      click_on 'Enable', match: :first

      click_on 'Schroeder-Jerde'
      expect(page).to have_content('Enabled')
    end
    it 'has a button that allows me to create a new merchant' do
      visit '/admin/merchants'

      expect(page).to have_button('Add a New Merchant')

      click_button 'Add a New Merchant'

      expect(current_path).to eq('/admin/merchants/new')
    end
  end
end