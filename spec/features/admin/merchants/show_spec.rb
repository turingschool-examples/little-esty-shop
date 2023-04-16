require 'rails_helper'

RSpec.describe 'Admin Merchants Show Page' do
  before :each do
    test_data
  end

  describe 'As an admin, when I visit the Admin Merchants Show page' do
    it 'I see the Merchants name' do
      visit admin_merchant_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)

      visit(admin_merchant_path(@merchant_2))

      expect(page).to have_content(@merchant_2.name)
    end
  end
end