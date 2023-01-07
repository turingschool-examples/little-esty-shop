require 'rails_helper'

RSpec.describe 'admin merchants index' do
  describe 'User Story 24' do
    it 'shows the name of each merchant in the system' do
      FactoryBot.create_list(:merchant, 3)

      visit admin_merchants_path

      expect(page).to have_content("Name0")
      expect(page).to have_content("Name1")
      expect(page).to have_content("Name2")
    end
  end
end