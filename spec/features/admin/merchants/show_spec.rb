require 'rails_helper'

RSpec.describe 'Admin Merchant Show' do
  describe 'view' do

    it 'I see the name of that merchant' do
      visit "/admin/merchants/#{@merchant_1.id}"

      expect(page).to have_content(@merchant_1.name)
    end
  end
end
