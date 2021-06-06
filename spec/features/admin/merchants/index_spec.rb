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
    end
  end
end