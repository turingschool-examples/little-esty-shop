require 'rails_helper'

RSpec.describe 'admin merchants index' do
  describe 'User Story 24' do
    it 'shows the name of each merchant in the system' do
      @merchants = FactoryBot.create_list(:merchant, 3)

      visit admin_merchants_path

      expect(page).to have_content(@merchants.first.name)
      expect(page).to have_content(@merchants.second.name)
      expect(page).to have_content(@merchants.third.name)
    end
  end
end